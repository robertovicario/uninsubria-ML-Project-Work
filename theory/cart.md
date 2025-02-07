### **CART - Spiegazione Semplice**  
**CART (Classification and Regression Trees)** è un algoritmo di machine learning che costruisce un **albero decisionale** per risolvere problemi di **classificazione** e **regressione**. L'idea principale è quella di suddividere i dati in gruppi omogenei, basandosi su caratteristiche specifiche, in modo che ogni gruppo (o foglia dell'albero) contenga dati simili.

1. **Suddividere i dati**: L'albero crea una serie di **domande (o "split")** che suddividono i dati in gruppi più piccoli. Ogni domanda riguarda una caratteristica (ad esempio, "L'altezza è maggiore di 160 cm?").
2. **Classificazione o regressione**: Quando arrivano nuovi dati, l'albero segue il percorso di decisione basato sulle domande e assegna una **classe** (se stiamo facendo classificazione) o un **valore numerico** (se stiamo facendo regressione).

---

### **Iperparametri Fondamentali**  
1. **Profondità massima dell'albero**  
   - Limita il numero di **livelli** dell'albero. Un valore alto può portare a un modello troppo complesso e sovradattato (overfitting), mentre un valore basso può causare un modello troppo semplice (underfitting).

2. **Numero minimo di campioni per foglia**  
   - Determina il **numero minimo di dati** che devono essere presenti in una foglia dell'albero. Un valore troppo basso potrebbe portare a foglie molto specifiche, mentre un valore troppo alto potrebbe ridurre la capacità dell'albero di cogliere le differenze nei dati.

3. **Numero minimo di campioni per suddivisione**  
   - Determina il numero minimo di dati che devono essere presenti in un nodo per effettuare una suddivisione. Impostare questo valore troppo alto potrebbe impedire di fare suddivisioni significative.

4. **Criterio di divisione (Gini o Entropia per la classificazione, MSE per la regressione)**  
   - **Gini**: Misura quanto un nodo sia "impuro", ossia quanto i dati siano mischiati. Più è basso il valore di Gini, più il nodo è puro.
   - **Entropia**: Simile al Gini, ma utilizza un calcolo basato sull'incertezza dei dati.
   - **MSE (Mean Squared Error)**: Per la regressione, misura quanto gli errori tra i valori previsti e i valori reali siano elevati.

---

### **Dimostrazione Matematica**  
1. **CART per la classificazione**  
   L'obiettivo è minimizzare la **misura di impurità** (ad esempio Gini o Entropia). Ogni volta che l'albero decide una suddivisione, cerca quella che riduce il più possibile l'impurità.

   - Per il **Gini**:
   \[
   Gini(t) = 1 - \sum_{i=1}^{m} p_i^2
   \]
   dove \( p_i \) è la probabilità che un dato appartenga alla classe \( i \) in un nodo \( t \). L'albero cerca di suddividere i dati in modo da minimizzare questo valore di impurità.

   - Per l'**Entropia**:
   \[
   Entropy(t) = - \sum_{i=1}^{m} p_i \log(p_i)
   \]
   L'idea è quella di ridurre l'incertezza, suddividendo i dati in modo che ogni nodo contenga dati di una singola classe.

2. **CART per la regressione**  
   Se il problema è di regressione, l'albero cerca di minimizzare il **MSE** (errore quadratico medio):
   \[
   MSE(t) = \frac{1}{N_t} \sum_{i=1}^{N_t} (y_i - \hat{y_t})^2
   \]
   dove \( y_i \) è il valore reale e \( \hat{y_t} \) è la previsione media per il nodo \( t \), e \( N_t \) è il numero di dati nel nodo.

---

### **Esempio Pratico**  
Immagina di voler costruire un albero decisionale per classificare persone in **"Acquistano Prodotto"** o **"Non Acquistano Prodotto"** in base a due caratteristiche: **Età** e **Reddito**.

I dati di addestramento potrebbero essere simili a questo:

| Età | Reddito | Acquista (Sì=1, No=0) |
|-----|---------|-----------------------|
| 25  | 30k     | 1                     |
| 35  | 40k     | 1                     |
| 45  | 50k     | 0                     |
| 50  | 60k     | 0                     |

Il **CART** procederà come segue:
1. Partirà dal nodo radice con tutti i dati e cercherà la **prima domanda** che separa al meglio le persone che acquistano da quelle che non acquistano.
   - Es: "Età < 40?" potrebbe essere una buona suddivisione.
2. Continuerà a dividere i dati ricorsivamente fino a quando raggiungerà la **profondità massima** o quando i nodi contengono troppo pochi dati per fare altre suddivisioni significative.
3. Alla fine, quando il modello vedrà una nuova persona, ad esempio con **Età = 30** e **Reddito = 45k**, seguirà il percorso dell'albero per determinare se acquista o meno il prodotto.

L'albero risultante potrebbe somigliare a qualcosa del tipo:

```
          Età < 40?
         /       \
      Sì           No
     /  \         /  \
   Acquista No  Acquista No
```

---

### **Conclusione**  
Il **CART** è un potente algoritmo di classificazione e regressione che costruisce alberi decisionali per suddividere i dati in gruppi omogenei. È facile da comprendere e da interpretare, ma la sua qualità dipende dalla scelta degli iperparametri, come la profondità massima e il numero di campioni per nodo. Quando configurato correttamente, può produrre modelli accurati e facili da interpretare.