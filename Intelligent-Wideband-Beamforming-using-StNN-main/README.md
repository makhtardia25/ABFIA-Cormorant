# A Low-complexity Structured Neural Network Approach to Intelligently Realize Wideband Multi-beam Beamformers

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

True-time-delay (TTD) beamformers can produce wideband, squint-free beams in both analog and digital signal domains, unlike frequency-dependent FFT beams. Our previous work showed that TTD beamformers can be efficiently realized using the elements of delay Vandermonde matrix (DVM), answering the longstanding beam-squint problem. Thus, building on our work on classical algorithms based on DVM, we propose neural network (NN) architecture to realize wideband multi-beam beamformers using structure-imposed weight matrices and submatrices. The structure and sparsity of the weight matrices and submatrices are shown to reduce the space and computational complexities of the NN greatly. The proposed network architecture has $$O(pLM logM)$$ complexity compared to a conventional fully connected L-layers network with $$O(M^2L)$$ complexity, where M is the number of nodes in each layer of the network, p is the number of submatrices per layer, and M >> p. We will show numerical simulations in the 24 GHz to 32 GHz range to demonstrate the numerical feasibility of realizing wideband multi-beam beamformers using the proposed neural architecture. We also show the complexity reduction of the proposed NN and compare that with fully connected NNs, to show the efficiency of the proposed architecture without sacrificing accuracy. The accuracy of the proposed NN architecture was shown using the mean squared error, which is based on an objective function of the weight matrices and beamformed signals of antenna arrays, while also normalizing nodes. The proposed NN architecture shows a low-complexity NN realizing wideband multi-beam beamformers in real-time for low-complexity intelligent systems.

For more information on the theory behind the algorithms, refer to the following resources:
[Paper](https://arxiv.org/abs/2503.20694)

## 📚 Citation

If you use this code, please cite:

```bibtex
@article{aluvihare2025low,
  title={A Low-complexity Structured Neural Network Approach to Intelligently Realize Wideband Multi-beam Beamformers},
  author={Aluvihare, Hansaka and Sivasankar, Sivakumar and Li, Xianqi and Madanayake, Arjuna and Perera, Sirani M},
  journal={arXiv preprint arXiv:2503.20694},
  year={2025}
}
```

Aluvihare, H., Sivasankar, S., Li, X., Madanayake, A. and Perera, S.M., 2025. A Low-complexity Structured Neural Network Approach to Intelligently Realize Wideband Multi-beam Beamformers. arXiv preprint arXiv:2503.20694.
