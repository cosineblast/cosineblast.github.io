
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

- I've started re-studying the DanceDanceConvLSTM paper.
Altough my original plans were to implement a DanceDanceConvolution like network for computational reasons,

I've noticed a detail that I have glossed over in DanceDanceConvLSTM, that is the fact that it _does_ utilize
music information when doing step placement, which feels right with me.
I shall also inspect the [transformer](https://arxiv.org/abs/2311.13687) based generation
to determine if they do that.

### 20/05/2026:

- I have started training a sample DanceDanceConvLSTM model for In The Groove 1 in [Rede Linux](https://linux.ime.usp.br/),
but the goku and vegeta servers were temporarily disabled for a reform of the place.

- I've restudied DanceDanceConvLSTM to better understand its architecture and
point out the next subjects to study and important notes for the development plan for this project.

- I've glossed over the transformer generation paper (which we will refer as the BAS2S paper) to check on its performance.

#### NOTES

As a somewhat experienced (average S16) player of Pump it Pump and having some experience writing my own charts for the game,
I could instantly note a few issues with the architecture of the original paper DanceDanceConvolution paper, the main ones being:
1. The step placement process doesn't place the steps aligned with the BPM of the game (in real charts, the steps are always placed within
fractions of a full beat measure), instead placing the steps in arbitrary positions, possibly misaligned with the BPM of the song.
2. The step selection process does not take music information into consideration, it only receives the step placements and tries to spit out the time outputs.
3. The chart generation models are trained on all available chart styles (technical, run, goofy). T
his is like trying train a model to generate text in different languages, or generate music in different musical styles.

The first two¹ were fortunately addressed in DanceDanceConvLSTM from 2025, but the third point is still untackled.

Additionally, the BPM detection often fails to detect the right offset for songs with variable or changing BPM.
Considering that the algorithm used by DDCLSTM is the same used by the software Arrow Vortex which I use for writing charts, I know that this works pretty bad
for BPM-chaning charts, requiring manual intervention and BPM change placement. This is even worse for charts with continuously changing BPMs.
In the training for Pump it up charts, I should remove these BPM-changing songs.

Another thing to point out is that pump it up charts have lots of gimmicks and details that should be filtered out when doing modelling.

¹: When I initially read DanceDanceConvLSTM, I didn't take into consideration that the model solves both problems, I thought it only solved number 2.:

Next steps:

- Read the Yoshua Bengio paper about music representation and log-melbands (used in all the chart generation reference papers, DDC, DDCLSTM, BAS2S).
- Read the ConvLSTM paper
- Read DDCLSTM again to get a better understanding of the architecture.
- Read the DDCLSTM code for the model to get right some questions left out (e.g how does it models BPM and difficulty?)
- Read the BAS2S paper.
- Define a cronogram for the project.

