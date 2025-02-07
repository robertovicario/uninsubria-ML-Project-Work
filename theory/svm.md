### **SVM Classifier - Spiegazione Semplice**  
Il **SVM (Support Vector Machine)** è un algoritmo di classificazione che cerca di **trovare la miglior linea (o iperpiano)** che separa i dati di due classi. Immagina di avere dei dati di due categorie, ad esempio **"Spam"** e **"Non Spam"**. L'SVM cerca una **linea** o **superficie** che separa i dati in modo che la distanza tra i punti più vicini delle due categorie sia massima. Questi punti più vicini sono chiamati **support vector**.

1. **Linea di separazione**: La **miglior linea** è quella che separa le classi con il massimo margine possibile.
2. **Margine**: È la distanza tra la linea di separazione e i punti più vicini di ciascuna classe.

In sostanza, SVM crea una linea (o iperpiano in spazi con più dimensioni) che separa al meglio i dati in due gruppi distinti.

---

### **Iperparametri Fondamentali**

1. **C (Parametro di regolarizzazione)**  
   - **Controlla il compromesso** tra ottenere una separazione perfetta dei dati e avere un margine ampio.  
   - Un valore **alto** di \( C \) penalizza gli errori di classificazione e cerca di ottenere una separazione più precisa, ma rischia di sovradattarsi ai dati (overfitting).  
   - Un valore **basso** di \( C \) rende il modello più flessibile, ma potrebbe non separare bene i dati (underfitting).

2. **Kernel**  
   - Il **kernel** è una funzione che permette a SVM di lavorare in spazi ad alte dimensioni, anche quando i dati non sono separabili linearmente.  
   - I kernel più comuni sono:
     - **Lineare**: per problemi lineari.  
     - **Radiale (RBF - Radial Basis Function)**: adatto per dati non lineari.  
     - **Polinomiale**: utile quando i dati non sono separabili in modo semplice.  
   - Il kernel trasforma i dati in uno spazio ad alte dimensioni dove è più facile separare le classi.

3. **Gamma (per il kernel RBF)**  
   - Controlla quanto lontano un punto influisce sulla classificazione.  
   - Un **gamma alto** rende il modello più complesso e rischia di adattarsi troppo ai dati (overfitting).  
   - Un **gamma basso** rende il modello più semplice, ma potrebbe non catturare tutte le complessità (underfitting).

---

### **Dimostrazione Matematica**  
L'obiettivo di un **SVM lineare** è trovare un iperpiano che separi i dati in due classi. L'iperpiano ha una forma matematica come:  
\[
w \cdot x + b = 0
\]
dove:
- \( w \) è il vettore dei pesi (normale all'iperpiano),
- \( x \) è il vettore di input (i dati),
- \( b \) è il termine di bias.

**SVM** cerca il massimo margine, che è la distanza tra il piano di separazione e i punti più vicini delle due classi. I punti più vicini sono chiamati **support vector**.

La **funzione di ottimizzazione** per massimizzare il margine è:  
\[
\min_{w, b} \frac{1}{2} \|w\|^2 \quad \text{con le restrizioni} \quad y_i (w \cdot x_i + b) \geq 1, \quad \forall i
\]
Dove \( y_i \) è la classe del punto \( x_i \) (1 o -1).  

Questo problema di ottimizzazione può essere risolto tramite la **programmazione quadratica**.

Nel caso di **SVM non lineare**, si usa un **kernel** per trasformare i dati in uno spazio più alto dove diventano separabili. Ad esempio, il **kernel RBF** è dato da:  
\[
K(x_i, x_j) = e^{-\gamma \|x_i - x_j\|^2}
\]
Quindi, invece di cercare una separazione lineare, il kernel mappa i dati in uno spazio dove la separazione diventa più facile.

---

### **Esempio Pratico**  
Immagina di voler classificare **fiori** in due categorie: **Iris Setosa** e **Iris Versicolor**, in base a due caratteristiche: **lunghezza del petalo** e **larghezza del petalo**. I dati sono separabili in due gruppi distinti.

1. **Costruzione della rete SVM**:
   - L'SVM cerca la **migliore linea** che separa i fiori di **Iris Setosa** (ad esempio, classe 1) dai fiori di **Iris Versicolor** (classe 0).
   - Trova la **linea di separazione** che massimizza la distanza tra i fiori più vicini dei due gruppi.

2. **SVM non lineare**:
   Se i fiori non sono separabili in modo lineare (ad esempio, se si hanno più dimensioni o se i dati non sono facilmente separabili), si può usare un **kernel RBF** per mappare i dati in uno spazio più alto e trovare una separazione.

Nel nostro esempio, se usiamo un **SVM lineare** e otteniamo un buon margine, l’algoritmo sarà in grado di **classificare nuovi fiori** come Iris Setosa o Iris Versicolor in base alla loro lunghezza e larghezza del petalo.

---

### **Conclusione**  
L'**SVM** è potente e funziona molto bene per problemi di classificazione, soprattutto quando i dati sono separabili. Tuttavia, può essere complesso da configurare, soprattutto quando si utilizzano **kernel** e si ha a che fare con grandi quantità di dati. La scelta di **C**, **kernel** e **gamma** è cruciale per ottenere buone prestazioni.