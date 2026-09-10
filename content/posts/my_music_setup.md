
# My music setup

I have _FINALLY_ achieved a music setup that achieves my petty requirements.
It's not perfect, but it works well enough for me.

## Part 1 - Soundcloud to Spotify to despair

I am a weird person. I like weird beep boop eletronic video game frequency modulated music. 
There are many ***EXCELLENT*** VGM indie artists that don't exist on platforms like spotify, but instead exist primarily on soundcloud (although many also exist on youtube).
And I want to listen to their precious music. So for the past 7 years, soundcloud has been my primary platform for discovering and listening to music.
Its recommendation algorithm works very well for me, except for the occasional guaranteed AI 2nd song in the "similar tracks" recommendation.

However, I recently have also started listening to other, more mainstream music, on Spotify. A now, I have a few issues.

- I wanna listen to stuff in both of them.
- Both platforms suffer from disapearing music. This has bitten me multiple times in the past, both in soundcloud and spotify, specially for remixes.
- Spotify CEO has some involvment with military and israel military stuff. Not a fan of that.

Well, these issues are enough for me to quit and start downloading music for myself.
Also, instead of giving my money to spotify, I can just donate it directly to artists I enjoy.

## Part 2 - Keeping stuff

The first step was to download all my music. This wasn't too difficult.
I made a few scripts and used `yt-dlp` to download stuff from youtube, and `spotdl` to download stuff from `spotify`.

Now, we have a directory with a bunch of music, and we need a way to share it with our phone.

There are two approaches for this:
1. Setting up a 24/7 media sever like navidrome, plex or jellyfin
2. Share files directly from computer manually or using syncthing

I decided to go with option 2, as I don't have a dedicated computer and I don't wanna have to deal with setting up servers right now.
This might change in the future.
I have set up syncthing on my phone and computer, and configured it to send stuff from my computer to my phone, but not backwards (I don't want to deal with conflicts,
and they are -> ***bound*** <- to happen with syncthing).

## Part 3 - Playlists

This is where things get tricky. I have decided to go with sharing files directly from my computer, so I need to store playlists as files
that both my computer and my phone understand. Fortunately, there's a very simple plaintext playlist format called m3u8, in which
a playlist can be represented by a text file with the music paths separated by newlines. I manually copied the playlists from soundcloud and spotify to
the text files. 

For playing stuff on my phone, mobile VLC worked flawlessly. It instantly detects the m3u8 files and treats them as playlists, and just works.

For playing stuff on my computer, well, it's complicated.
You can use whatever player you want to play songs, but if you want to be able to play and _browse_ playlists, VLC isn't an option.
This is because VLC can only load playlists file into the current queue, it can't just browse to show the files of a playlist file without affecting the current
queue. 

After looking a bit for players, I stuck with the strawberry player. It looks old but I love this style.
It has the same "playlist-is-queue" model as VLC, but
it allows for multiple queues tabs, so I can at least browse other playlists without affecting the music queue.
The final touch was changing its music search feature so it doesn't group by artist or anything like that.
I don't use its "favorite playlist" thing, since it copies the playlists to its internal database thing, and I don't want that.
Bonus: It supports Last.FM!

Editing the playlists still happen within the text editor tho, but it's fine tbh.

Honorable mentions:
- quod libet is pretty nice. It doesn't work for me since it imports playlists into its internal database and
I have this "playlist-is-text-file" setup, but if I wasn't syncing music with my phone, this is what I'd use.
- just using a dedicated music server: This is honestly what I'm going to do if this setup of mine annoys me more even by one inch. It seems the right thing to do, but i'm just too stubborn.

# Shoutouts

Some artists that I love listening to:

- +TEK
- Yiter
- Tokonemu
- Spy Trolling
- RRThiel
- Tudd
- john "joy" tay
- R3
- stinkbug
- MaxOKE
- ipi
- naruto2413

# Appendix

My media management nushell script as of September 2026.

```
export def "download sc" [url: string] {
  yt-dlp -t mp3 --embed-thumbnail --embed-metadata -o '%(title)s - %(artist)s.%(ext)s' --sleep-interval 10 --cookies-from-browser firefox  $url
}

export def "download yt" [url: string] {
  yt-dlp -t mp3 --embed-thumbnail --embed-metadata -o '%(title)s - %(channel)s.%(ext)s' --sleep-interval 10 --cookies-from-browser firefox  $url
}

# check if playlist files are ok
export def check [] {
  let playlists = glob *.{m3u,m3u8} | each { path basename }

  print $"checking the following playlists:"

  print ($playlists | each { $"- (ansi yellow)($in)(ansi reset)"} | str join "\n")

  let result = $playlists | each { |playlist|
    open $playlist | lines | where { path exists | do { not $in } } | each { |file| [$playlist $file] }
  } | flatten

  print ""

  if ($result | length) == 0 {
    print $"(ansi green)all playlists are ok >v<(ansi reset)"
  } else {
    print $"found missing files in the following playlists:"
    print ($result | each { $"- ($in.0): (ansi red)($in.1)(ansi reset)" } | str join "\n")
  }
}

# Create a new playlist with the files under the current subdirectory in modified order
export def new-playlist [name: string] {
  if (pwd | path basename) == 'music' {
    error make 'This operation must be run from directory under music, not music itself.'
  }

  let filename = if ($name | path parse | get extension) not-in [m38 m3u8] {
    $name | path parse | upsert extension m3u8 | path join
  }

  let files = ls | sort-by modified | get name

  let warn = $files | where { ($in | path parse | get extension) not-in [mp3 wav m4a flac ogg jpg png]}

  if ($warn | length) > 0 {
    print $"(ansi yellow)warning(ansi reset): the following files were included but have weird extensions"
    print ($warn | each { $"- ($in)"} | str join "\n")
  }

  print $"Saving ($files | length) files to ($filename)"

  $files | str join "\n" | save $filename
}

# Given an audio file (presumably wav) and an image file,
# writes out a .mp3 copy of the file containing the image as the thumbnail
# the image is assumed to come from the same file name but with jpg instead of the original extension
export def embed-image [audio: path, --image_path: path, --result_path: path] {
  let image = $image_path | default ($audio | path parse | upsert extension 'jpg' | path join)

  let result = $result_path | default ($audio | path parse | upsert extension 'mp3' | path join)

  ffmpeg -i $audio -i $image -map 1 -map 0 -disposition:0 attached_pic $result
}

# Add a music to a playlist
export def add [playlist: path, file: path] {
  if not ($playlist | path exists) {
    error make $"playlist file '($playlist)' not found"
  }
  if not ($file | path exists) {
    error make $"file '($file)' not found"
  }
  if ($playlist | path parse | get extension) != m3u8 {
    error make $"file '($playlist)' does not seem to be a .m3u8 file"
  }

  $"($file)\n" | save $playlist --append

  $"(ansi green)added ($file) to ($playlist)(ansi reset)"
}

# Mark a song as made by siivagunner
export def siiva [file: path] {
  let new_file = $"SiIvagunner - ($file)"
  mv $file $new_file
  $"(ansi green)renamed to ($new_file)(ansi reset)"
}

export def orphans [] {
  let playlists = glob *.{m3u,m3u8}
  let files_in_playlists = $playlists | each { open $in | lines } | flatten
  let orphans = ls | get name | where { $in not-in $files_in_playlists }

  $orphans | where { ($in | path parse | get extension) not-in [m3u m3u8 nu ""] }
}
```
