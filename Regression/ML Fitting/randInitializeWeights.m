function [W] = randInitializeWeights(inSize, outSize)

epsilonInit = sqrt(6/(inSize + outSize));
W = rand(outSize, 1 + inSize) * 2 * epsilonInit - epsilonInit;

end