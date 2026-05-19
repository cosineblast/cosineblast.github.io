
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


