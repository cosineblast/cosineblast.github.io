
# Learn it Up - Logs 

### 12/05/2026: 


- Renamed repo to learn-it-up (and set up a redirection repo page on tcc-learn-it-up)
- Startd trying to run original dance dance convolution repository, but failed once
realized that the project uses both tensorflow and python 2, which is a pain in the ass which I don't want to deal with right now. 
I'll be running instead Dance Dance Conv LSTM aka [DDCL](https://github.com/miguelomalley/DDCL).

### 13/05/2026:

- Watched [3b1b](https://www.youtube.com/@3blue1brown) (best yt channel)
videos on [transformers](https://www.youtube.com/watch?v=wjZofJX0v4M)
and [attention](https://www.youtube.com/watch?v=eMlx5fFNoYc) mechanism to get a
refresh of the general idea.

### 14/05/2026:

- I've read [Attention is All You Need](https://www.youtube.com/watch?v=eMlx5fFNoYc) to
understand some details glossed over by the 3b1b video
and get references for other important topics of which I need to review.

### 15/05/2026:

- I've read [Deep Residual Learning for Image Recognition](https://arxiv.org/abs/1512.03385) to understand residuals which are used in Attention is All You Need.
- I've read [Batch Normalization: Accelerating Deep Network Training by Reducing Internal Covariate Shift](https://arxiv.org/abs/1502.03167) to understand batch normalization which is used in Attention is All you Need.

**IDEA:**
Consider training LSTM models using [recurrent batch normalization](https://arxiv.org/abs/1603.09025)
and [residual connections in LSTMs](https://arxiv.org/abs/1701.03360)
To consider this, must search on existing applications of these to LSTMs in other papers to consider results.

### 16/05/2026:

- Reworked website UI

### 18/05/2026:

- I've read [Sequence to Sequence Learning with Neural Networks](https://arxiv.org/abs/1409.3215).

**QUESTION:**
DanceDanceConv and DanceDanceConvLSTM both use an architecture 
simular to the encoder-decoder. Could doing something like reversing the input possibly improve the model like it does with seq2seq? 

- I've read [Neural Machine Translation by Jointly Learning to Align and Translate](https://arxiv.org/abs/1409.0473)
to learn the original attention mechanism proposal for RNNs

**QUESTION:**
Could adding this attention encoder-decoder mechanism to DanceDanceConvolution help increase performance without adding the
computational costs of ConvLSTM?

### 19/05/2026:

- I've read Attention is All you need once again to understand the main differences between its attention approach than Learning to
Align and Translate.

**QUESTION:**
Honestly, the original approach is much simplier, but I see the appeal of the transformer.
I wonder if you would get great performance in RNN attention based networks by adding residuals and/or normalization. Food for thought.

- I've started re-studying the DanceDanceConvLSTM (DDCL) paper.
Altough my original plans were to implement a DanceDanceConvolution like network for computational reasons,

I've noticed a detail that I have glossed over in DanceDanceConvLSTM, that is the fact that it _does_ utilize
music information when doing step placement, which feels right with me.
I shall also inspect the transformer-based generation paper
[_Beat-Aligned Spectrogram-to-Sequence Generation of Rhythm-Game Charts_](https://arxiv.org/abs/2311.13687)
(Yi2023) to determine if they do that.

### 20/05/2026:

- I have started training a sample DanceDanceConvLSTM model for In The Groove 1 in [Rede Linux](https://linux.ime.usp.br/),
but the goku and vegeta servers were temporarily disabled for a reform of the place.

- I've restudied DanceDanceConvLSTM to better understand its architecture and
point out the next subjects to study and important notes for the development plan for this project.

- I've glossed over the Yi2023 paper to check on its performance.

#### NOTES

As a somewhat experienced (average S16) player of Pump it Pump and having some experience writing my own charts for the game,
I could instantly note a few issues with the architecture of the original paper DanceDanceConvolution paper, the main ones being:
1. The step placement process doesn't place the steps aligned with the BPM of the game (in real charts, the steps are always placed within
fractions of a full beat measure), instead placing the steps in arbitrary positions, possibly misaligned with the BPM of the song.
2. The step selection process does not take music information into consideration, it only receives the step placements and tries to spit out the time outputs.
3. The chart generation models are trained on all available chart styles (technical, run, goofy). T
his is like trying train a single model to translate text from english, using datasets of various text in different languages.

The first two¹ were fortunately addressed in DanceDanceConvLSTM from 2025, but the third point is still untackled.

Additionally, the BPM detection often fails to detect the right offset for songs with variable or changing BPM.
Considering that the algorithm used by DDCLSTM is the same used by the software Arrow Vortex which I use for writing charts, I know that this works pretty bad
for BPM-chaning charts, requiring manual intervention and BPM change placement. This is even worse for charts with continuously changing BPMs.
In the training for Pump it up charts, I should remove these BPM-changing songs.

Another thing to point out is that pump it up charts have lots of gimmicks and details that should be filtered out when doing modelling.

¹: When I initially read DanceDanceConvLSTM, I didn't take into consideration that the model solves both problems 1 and 2, I thought it only solved number 2.

Next steps:

- Read the _Building Musically-Relevant Audio Features Through
Multiple Timescale Representations_ (Bengio2012) paper about music representation and log-melbands (used in all the chart generation reference papers, DDC, DDCLSTM, BAS2S).
- Read the ConvLSTM paper
- Read DDCLSTM again to get a better understanding of the architecture.
- Read the DDCLSTM code for the model to get right some questions left out (e.g how does it models BPM and difficulty?)
- Read the BAS2S paper.
- Define a cronogram for the project.

### 21/05/2026

Looking at the references for Bengio2012, I've read Chapters 2 and 4 of _Algorithms for Classifying Recorded Music by Genre_ (Bergstra2006b),
which surveys several basic important concepts in audio processing in its chapter 2, specially
the Mel, Sone and Phon scales, sound pressure and intensity.

Additionally, it explains and tests various audio feature extraction methods, introducing Mel-scale Phon Coefficients (MPC) and Mel-scale Sone Coefficients,
which make quite some sense.


## 22/05/2026

I've read _Temporal Pooling And Multiscale Learning For Automatic Annotation And Ranking Of Music Audio_ (Hamel2011),
since they are a reference for Bengio2012's usage of PCA in features but
honestly I didn't really understand the whole PCA feature thing.

## 23/05/2026

I've read Bengio2012. I didn't really understand their PCA-based approach for musical feature in their models,
but this technique is not used in later work such as DDC or DDCL. Instead, what is used is the approach to use
multiple overlapping timescales to process information in the onset detection.

I've read DDC once again. Their model is now very clear to me, both in terms of audio information retrieval, step placement and step selection.
I have realized something interesting: You could technically make a program that receives some live audio input from a microphone and generate the
step placements on the fly, depending on the LSTM unroll parameter for the encoder. For the parameters presented in DDC, this would be 2 seconds of delay.

I've read _Convolutional LSTM Network: A Machine Learning Approach for Precipitation Nowcasting_ (Shi2015) which introduces and explains ConvLSTM.

I've read the step placement model of DDCL once again, and I now understand how it works.

### NOTES

- The ConvLSTM of Shi2015 uses peephole LSTM. (Could working memory connections improve things? Who knows)
-  In DDC, the output of the LSTM is the concatenation of all the outputs over the LSTM unrolling. This isn't the case in DDCL, where the
output of the LSTM layer is just the output of the last layer.
- DDCL uses an integer to determine the difficulty for the model, instead of a one-hot encoding like DDC.

## 24/05/2026

I've read Yi2023 once again.

### NOTES

- The way they compare their models with DDC seems to be different from the way DDCL compares their models with DDC, since Yi2023 reports a very different performance of DDC
compared to DDCL, so it is a bit difficult to compare between DDCL and Yi2023... I guess I'll be doing that for pump!
- They use only melband one channel in their implementation instead of three.

## 25/05/2026

I've started studying the SM file format and gimmicks in Pump it Up files, trying to understand warp effect.s

## 26/05/2026

I've finished understanding the different category of gimmick charts and how they're used in Stepmania 5 files.

BPM changes may be tricky, but fortunately, the most common way of applying gimmicks is through scrolls, and speed sections, which
do not affect note timing.
It should be possible to filter warp, and fake blocks

## 29/05/2026

I've started writing the StepMania file parser and filter for the upcoming models.

## 31/05/2026

I've implemented absolute time audio extraction and stepfile simulation (for manually comparing the absolute times with the note times of real charts).

## 01/06/2026

I've studied the fourier transform through characteristic functions to have a better understanding of fourier analysis and synthesis.

As a result of my studies, have this over-engineered fizzbuzz without branching or modular arithmetic:

```py
import math

freqs  = [-1.00, -0.80,-0.67, -0.60, -0.40, -0.33, -0.20,
         -0.00, 0.20 , 0.33 , 0.40 , 0.60 , 0.67 , 0.80 ]
norms  = [11.00, 6.00 ,5.00 , 6.00 , 6.00 , 5.00 , 6.00 ,
         11.00, 6.00 , 5.00 , 6.00 , 6.00 , 5.00 , 6.00 ]

def fizzbuzz(x):
    result = 0
    for freq, norm in zip(freqs, norms):
        result += norm * math.cos(2 * math.pi * freq * x)
    i = result / 30
    return [x, 'Fizz', 'Buzz', 'FizzBuzz'][round(i)]

for i in range(1, 101):
    print(fizzbuzz(i))
```

## 02/06/2026

I've started implementing feature extraction using the essentia library and the same parameters as DDC.

## 03/06/2026

Implemented the command line interface to extract SSC information and audio features from real pump it up datasets.

## 04/06/2026

Talked to members of the community to learn that on level S18 and above, the difficulty of songs changes considerably if the
arrows are mirrored vertically. Updated the CLI tool to reflect that.
Minor improvemetns in the command line implementation for the project.

## 6/6/2026

- Added support for the [`uv`](https://docs.astral.sh/uv/) package manager in the project repo, documenting python package versions for
reproducibility.
- Started working towards analyzing the post-filtered dataset of pump it up charts, using a marimo notebook.
I've started trying out julia recently, and Pluto.jl, their notebook plataform, it's pretty great! However,
since I have already started this with python, I will continue with python going forward. I will use marimo notebooks
in general, since they have plenty of the niceties of pluto, but for python.
Most charts are around S16, with a standard deviation of four.

### NOTES

Turns out that there are 6 files that were processed but did not have any charts, since all of their charts were filtered out for
having gimmicks. I shall filter these chartless files out in the future.

## 8/6/2026

I've ran the existing code for learn-it-up project in the Rede Linux servers, and all the processing pipelines, and analytics notebooks ran well!

I've decided to have a look at some of the data in the project, and learned a terrible fate: most charts have very weird BPMs in relationship to their real bpms.

See the chart for DUEL. 

## 9/6/2026

- Implemented PyTorch code for DanceDanceConvolution CNN and C-LSTM onset model.

### NOTES

I was thinking on starting with DDCL, but considering the BPM issues I found yesterday, I'm starting with DDC since its main weakness - using absolute time,
can delay me with the fate of dealing with Pump it Up's weird BPMs.

## 10/6/2026

- Started implementing dataset loading for the CNN onset model

python3 in my machine takes 1 second to run a `pass` loop from 1 to 14 million.
there are 14 million audio feature samples in the dataset.
i hate my life.
i wish julia was real.

## 11/6/2026

I started training the CNN onset model on the rede linux vegeta machine.
The initial performance check was done by checking the average loss over all the frames in the validation set.
I initially trained with an Adam optimizer, dropout of zero, and 0.001 learning rate.

I trained 80 epochs. While training I noticed that the validation average loss was going really bad over the validation set, growing steadily.
This made me realize that the dropout was initially set to zero (actually, I hadn't even placed the dropout layers).

Note: When training, we normalize the audio features for each _audio file_ so that each audio has mean zero and variance one.
DDC does this using the mean and variance of the **whole validation** dataset (???)

## 12/6/2026

Throughout the day, I trained 50 epochs of a 0.5 dropout model with SGD 0.1 lr 1.0 weight decay which is used in the DDC scripts.
The training regimen is not specified in DDC, neither the learning rate, nor the number of epochs, or weight decay.
This time, the validation set loss was not really going down, nor increasing. I don't know if this is better tbh.

I added unit tests to the CNN dataset loading process to make sure it was working as expected, and that the following optimizations were safe to make.
I have optimized the data loading process to avoid having to check the indices in every call, by adding some padding to the data.
It now takes around 30 seconds to iterate over the whole training dataset in vegeta, which should cost us around 30 seconds per epoch. Not too bad.
I could optimize out the binary search as well with a cache, which could reduce it further, but I think I have better stuff to do.

### NOTES

While 'interactively studying' the dataset at night, I noticed a few important things for the project:

1. The onset model probably should not be trying to add onsets to end-of-hold notes.
Hold notes are usually there either for stylistic/difficulty reasons, or because the music has a sustained musical note.
When doing stepcharting, I usually think when to _make_ a note a hold note, not in terms of when a note should _stop_ being held.
The audio criteria for starting a hold note is not the same for ending one.

I think it would make more sense to make so that the onset model treats holds as regular-ish notes, and then have an auxiliary model tell which notes
should be made hold notes (and for how long).

Also, kpop onsets are weird. I should look into that.

## 13/6/2026

I have implemented the aligned precision-recall AUC metric which is used by DDC. Running it on a randomly initialized CNN network gave me scores of around 0.05,
whereas running it in a single epoch trained CNN gave me scores of around 0.4-0.5:
This gave me some hope, since it means the model may be at least learning _something_ in the original configuration.

On the other hand, a single-epoch network doesn't yield such great results for other metrics:

One epoch (weird learning parameters, buggy evaluation):
```
epoch 1/100.
evaluation=FullEvaluation(
  avg_precision=np.float64(0.061953475162220745),
  avg_recall=np.float64(0.9715870720853564),
  avg_fscore=np.float64(0.11457087720499035),
  avg_loss=np.float32(0.5484841),
  avg_raw_auc_score=0.5265657523938453,
  avg_aligned_auc_score=0.41927391788468876,
  avg_accuracy=0.1732478208552864
)
```

Randomly initialized network (weird learning parameters, buggy evaluation):
```
FullEvaluation(
  avg_precision=np.float64(0.05350902051179025),
  avg_recall=np.float64(0.9432253049938485),
  avg_fscore=np.float64(0.10031142426696686),
  avg_loss=np.float32(0.7056311),
  avg_raw_auc_score=0.051663703507923806,
  avg_aligned_auc_score=0.04707373093129912,
  avg_accuracy=0.10995156341944352
)
```


(Raw AUC score uses the raw scores from the model output, aligned AUC scores is the one used by DDC,
that aligns the peak scores with the real onsets if they are within a 20 milliseconds of one another.
PS: The aligned scores should always be higher than the raw ones, but due to a bug, that's not the case
).

I then implemented f1 score, precision, and accuracy evaluation scores, in a similar matter to the ones used by DDC.

It would be nice to make a plot of the real onsets for a chart, and the scores suggested by the model.
However I haver other stuff to do:

- Implement the DDC LSTM step placement dataset loading.
- Implement the DDC LSTM step selection models.
- Implement the DDC LSTM step placement models.
- Implement the DDCL step placement models.
- Implement the DDCL step selection models.
- If any model gives us any decent performance, augment chart info with the max shen dataset

## 14/6/2026

The CNN model does not really learn anything when given the weird learning configuration
used by the script (learning rate  =0.1, weight decay=1.0), running 100 epochs gave little change in loss
(around `0.547`), and no change in anything else.

- Fixed an offset bug in the model evaluation code
This explains why the aligned scores were higher than the raw scores somehow.

- Added unit tests to evaluation. This would be a nice target for property based testing.

Ran the evaluation on the model with one epoch of training, both on the training and validation set.
The model has basically no gain of performance, and it probably means that the model is underfitting.
This makes sense since weight decay used in the script is absurdly high.
I'm going to try it with some more reasonable learning parameters.

Validation and training set evaluations for original learning parameters with one epoch:
```
epoch 1/1.
evaluation=FullEvaluation(
  avg_precision=np.float64(0.07130479244259558),
  avg_recall=np.float64(0.9999052905772364),
  avg_fscore=np.float64(0.13090117183217154),
  avg_loss=np.float32(0.54657215),
   avg_raw_auc_score=0.5265657523938453,
  avg_aligned_auc_score=0.5356086886851058,
   avg_accuracy=0.26286247016044945)

epoch 1/1.
training evaluation=FullEvaluation(
  avg_precision=np.float64(0.06494214096904),
  avg_recall=np.float64(0.9999979033529579),
  avg_fscore=np.float64(0.11979563030314623),
  avg_loss=np.float32(0.5450856),
  avg_raw_auc_score=0.5245296126221776,
  avg_aligned_auc_score=0.5324701066159356,
  avg_accuracy=0.24408444356515335)
````

Randomly initialized network performance:

```
FullEvaluation(
  avg_precision=np.float64(0.24093813185151294),
  avg_recall=np.float64(0.8009248094725991),
  avg_fscore=np.float64(0.3599704888309575),
  avg_loss=np.float32(0.6690475),
  avg_raw_auc_score=0.052920011201352556,
  avg_aligned_auc_score=0.2240785736249959,
  avg_accuracy=0.8563030075667782)
```

I ran it with a proper configuration (one epoch of adam with a learning rate of 0.001), and well:

```
epoch 1/1.
  evaluation=FullEvaluation(
       avg_precision=np.float64(0.6483496168554931),
       avg_recall=np.float64(0.7703568652144877),
>>>    avg_fscore=np.float64(0.6984546978182594),
       avg_loss=np.float32(0.14726742),
       avg_raw_auc_score=0.3823113868904456,
>>>    avg_aligned_auc_score=0.7091686654382708,
       avg_accuracy=0.9689086687203682)
```

This is a _EXCELLENT_!!!!

In one (1) epoch, we got an fscore of 0.698, and an aligned auc score 0.709, and an aligned accuracy of 96%!
For reference, the official DDC LSTM model got an AUC of 0.680 and 0.691 f-score!

In other words: we have successfully replicated the step placement performance of DanceDanceConvolution for Pump it Up!

We still have a long journey to go:

- Implement the LSTM onset detection
- Implement the step selection models
- Implement DanceDanceConvLSTM
- Add NPS info
- Try different data models
- Add piucenter info

And I'm very excited to try all that!

PS: the fact that DDC step selection does not use difficulty information nor musical features bothers me so much.

## 15/6/2026

Today I showed the project to Ronaldo, started organizing the monograph text, and started implementing the LSTM for step selection.

Upon pondering about the data loading task for LSTM, I realized there are a few different ways of going about handling the input sequences in batches for epochs.

The way DDC does it, is to randomly select a chart, and randomly select a sequence of 100 steps in that chart, pick 64 of these sequences, and call that the batch.
Then, repeat again and again and again. The issue with doing that, is that after some time training, while many sequences will not likely be seen by the model,
others will be seen multiple times. In its codebase, Dance Dance Convolution acknowledges this in a comment:

```py
def get_random_subsequence(self, subseq_len, **feat_kwargs):
  ...
  #TODO: first sequence incredibly unlikely to appear, balance this
  ...
```
I don't like this approach. I believe epochs should span all samples, prefeably once. To deal with this when picking sequences for batches, I decided to divide the
chart steps in blocks of size 100, implement a function that selects a step block given an index, and uniformly sample 64 of those blocks to build each batch, spanning
all blocks once per epoch.

The issue, is that charts don't usually have multiple-of-100 steps in them, and the model input expects all the sequences in a batch to have the same length.
So, there are a few approaches to handle those remainder-by-100 steps in charts I thought of:

1. Drop sequences with less than 100 steps.
2. Force sequences to have size 100, allowing overlapping between the end of the penultimate sequence and the start of the last sequence of a chart when the step count is not divisible by 100.
3. Use batches of variable length, so that the sequences of length 100 (which are most of them) all fall in the same batches, and the sequences with the
  remaining steps fall in shorter batches. This can be done by implementing a custom pytorch Sampler class.
  When sampling in this mode, a decision to be made is what to do when a batch of 100-step-sequences is being built, but a sequence with less than 100 steps is found.
  One could yield the existing batch to the model, even if it has less than 64 elements, or to delay yielding the element until the current batch is full with 64 sequences.
  Another option is the delay these sequences with less than 100 elements to the end of the dataset altoghether.
4. Considering that the output of our model is an LSTM-processed sequence of step predictions, one for each element of the sequence, we can just pad shorter sequences up to size 100,
and ignore the model output of the padded input elements. This can be done by multiplying the resulting loss with a mask of ones and zeros (e.g `[1,1,...,0,0]`) with ones
in the positions of real steps, and zero of the position of padded garbage steps. This way, the propagating gradient of the loss will be zero regarding the padded steps,
as if they weren't there.

I like option 4.

## 16/6/2026

I implemented and trained the LSTM step selection model of DanceDanceConvolution, and trained it for 100 epochs, I achieve an accuracy of 57% in the dataset.
Looking good!

PS: In this version of the model, I forgot to include the time-until-next-step feature in delta time.

## 17/6/2026

I wrote a program to allow me to see the generated chart of a music file (writing the chart to disk is still underway).

Running it with the dropout turned on, sometimes the model decides to generate a bunch of holds instead of single step notes.
This is very interesting, but it shows that the current way the model decides which notes should be holds or not kind of sucks,
since start of holds and end of holds are treated the same. If the model decides to make a chart short-hold heavy, the effective
note density of the model is basically halved.

## 18/6/2026

Refactored somethings in the models and selection notebook:
I had forgotten to add the time before the next step in the delta time. It was reaching a plateau of 56%, and now it can reach 59%, which
is really close to the 60% of best performance in the original paper, and already better than the 45% of best performance in the InTheGroove dataset in the original paper.
(considering DCC Fraxtil Dataset with delta time only).

It is now easier to specify the LSTM layers and hidden state size from the notebook.
I ran 100 epochs for the selection model other configurations such as 3 layers or 256 hidden, and didn't see any significant improvements,
all of these still capping at 59% maybe we can do better if we train it for 6 hours like in DDC, who knows.

In any way, we have achieved the metrics of DanceDanceconvolution for both step placement and step selection in Pump it Up.

Next steps:
- Implement the chart generation program and website for public access and evaluation
- Document stuff
- Implement the DanceDanceConvLSTM models
- Implement sanitizing StepP1-specific gimmick notes (like vanish) to allow training in pre-phoenix datasets
- Add the PIUCenter annotated datasets as input to the models

