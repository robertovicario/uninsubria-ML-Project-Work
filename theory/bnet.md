### **Bayesian Network Classifier - Spiegazione Semplice**  
Un **Bayesian Network Classifier** è un modello che usa la **probabilità** per classificare i dati, ma con un'importante differenza rispetto al **Naïve Bayes**:  
- Nel **Naïve Bayes**, tutte le caratteristiche sono indipendenti.  
- Nel **Bayesian Network**, le caratteristiche possono essere **dipendenti tra loro**.  

Funziona così:  
1. **Crea una rete probabilistica**: Ogni variabile (caratteristica) è un nodo e le relazioni tra di esse sono rappresentate con collegamenti (archi).  
2. **Impara dai dati**: Calcola le probabilità condizionate tra le variabili.  
3. **Classifica nuovi dati**: Usa la **Regola di Bayes** per calcolare la probabilità di ogni classe e sceglie la più probabile.  

È utile quando alcune caratteristiche dipendono da altre, come in una diagnosi medica: la presenza di febbre può essere collegata alla tosse o a un'infezione.  

---

### **Iperparametri Fondamentali**  
1. **Struttura della Rete**  
   - Decide **quali variabili sono collegate**.  
   - Può essere fissata in anticipo o appresa dai dati.  

2. **Probabilità Condizionate**  
   - Ogni nodo ha una **Tabella delle Probabilità Condizionate (CPT)**, che descrive la probabilità di ogni valore dato i valori delle variabili collegate.  

3. **Metodo di Inferenza**  
   - **Inferenza esatta** (usata per reti piccole).  
   - **Inferenza approssimata** (necessaria per reti grandi, come Monte Carlo Sampling).  

---

### **Dimostrazione Matematica**  
Un **Bayesian Network** rappresenta la distribuzione congiunta delle variabili come:  
\[
P(X_1, X_2, ..., X_n) = \prod_{i=1}^{n} P(X_i | \text{genitori}(X_i))
\]
dove **genitori(Xi)** indica le variabili da cui dipende \( X_i \).  

Per classificare un dato con una classe \( C \), usiamo la **Regola di Bayes**:  
\[
P(C | X) = \frac{P(C) \cdot P(X | C)}{P(X)}
\]
ma, grazie alla struttura della rete, \( P(X | C) \) viene calcolato considerando solo le dipendenze effettive tra le variabili.  

Se abbiamo una rete con 3 variabili \( A, B, C \) con dipendenze:  
\[
P(A, B, C) = P(A) P(B | A) P(C | A, B)
\]
allora possiamo calcolare facilmente le probabilità senza trattare tutte le combinazioni possibili.  

---

### **Esempio Pratico**  
Supponiamo di voler classificare un paziente come **Malato** o **Sano** in base a **Febbre** e **Tosse**.  

#### **Struttura della Rete**  
- La variabile **Malattia** influenza **Febbre** e **Tosse**.  
- La **Febbre** e la **Tosse** possono essere dipendenti tra loro.  

| Malattia | P(Febbre | Malattia) | P(Tosse | Malattia) |
|----------|---------|---------|
| Sì       | 0.8     | 0.7     |
| No       | 0.2     | 0.1     |

Se arriva un paziente con **Febbre e Tosse**, calcoliamo:  
\[
P(Malattia | Febbre, Tosse) \propto P(Malattia) P(Febbre | Malattia) P(Tosse | Malattia)
\]
e scegliamo la classe più probabile.  

---

### **Conclusione**  
Il **Bayesian Network Classifier** è più potente del **Naïve Bayes** perché tiene conto delle dipendenze tra variabili, ma è più complesso da costruire e calcolare.