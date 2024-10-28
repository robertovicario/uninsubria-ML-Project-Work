import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import learning_curve

def plot(model, X, y, label, color):
    train_sizes, train_scores, test_scores = learning_curve(
        model, X, y, cv=10, scoring='accuracy', train_sizes=np.linspace(0.1, 1.0, 10), n_jobs=-1
    )
    train_scores_mean = np.mean(train_scores, axis=1)
    test_scores_mean = np.mean(test_scores, axis=1)
    test_scores_std = np.std(test_scores, axis=1)
    
    plt.plot(train_sizes, test_scores_mean, 'o-', color=color, label=label)
    plt.fill_between(train_sizes, 
                     test_scores_mean - test_scores_std,
                     test_scores_mean + test_scores_std,
                     alpha=0.1, color=color)
