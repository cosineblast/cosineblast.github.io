
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
