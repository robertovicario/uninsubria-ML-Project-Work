### **Naïve Bayes Classifier - Spiegazione Semplice**  
Il **Naïve Bayes Classifier** è un algoritmo di classificazione basato sulla **probabilità**. Funziona così:  

1. **Impara dai dati passati**: Calcola la probabilità di ogni classe e la probabilità delle caratteristiche (es. parole in un testo) all'interno di ogni classe.  
2. **Applica la regola di Bayes**: Quando arriva un nuovo dato, calcola quale classe è la più probabile.  
3. **Assegna la classe più probabile**.  

Viene chiamato **"Naïve" (ingenuo)** perché assume che le caratteristiche siano **indipendenti tra loro** (cosa che spesso non è vera, ma il modello funziona comunque bene in molti casi).  

---

### **Iperparametri Fondamentali**  
Gli iperparametri principali dipendono dal tipo di Naïve Bayes usato:  

1. **Distribuzione delle probabilità**:  
   - **Gaussian Naïve Bayes**: Usa la distribuzione normale (adatto a dati numerici).  
   - **Multinomial Naïve Bayes**: Usa conteggi di frequenza (adatto a testi).  
   - **Bernoulli Naïve Bayes**: Usa valori binari (adatto a dati con presenza/assenza di feature).  

2. **Smoothing di Laplace (\(\alpha\))**:  
   - Serve per evitare problemi quando una parola o caratteristica non è mai apparsa in una classe.  
   - Valore comune: **\(\alpha = 1\)** (Laplace Smoothing).  

---

### **Dimostrazione Matematica**  
Il Naïve Bayes usa la **Formula di Bayes**:  
\[
P(C | X) = \frac{P(X | C) P(C)}{P(X)}
\]
dove:  
- \( P(C | X) \) è la probabilità che il dato \( X \) appartenga alla classe \( C \) (posterior).  
- \( P(X | C) \) è la probabilità di osservare \( X \) se la classe fosse \( C \) (likelihood).  
- \( P(C) \) è la probabilità della classe \( C \) (prior).  
- \( P(X) \) è la probabilità del dato \( X \) (e può essere ignorata per la classificazione).  

Poiché assumiamo che le caratteristiche siano **indipendenti**, possiamo scrivere:  
\[
P(X | C) = P(x_1 | C) P(x_2 | C) ... P(x_n | C)
\]
e quindi:  
\[
P(C | X) \propto P(C) \prod_{i=1}^{n} P(x_i | C)
\]
Il Naïve Bayes classifica il dato nella classe con la **probabilità più alta**.  

---

### **Esempio Pratico**  
Immaginiamo di voler classificare email in **Spam** o **Non Spam** in base alla presenza di parole.  

| Parola  | P(Spam) | P(Non Spam) |
|---------|--------|-------------|
| "Gratis" | 0.8    | 0.1         |
| "Offerta" | 0.7    | 0.2         |
| "Meeting" | 0.1    | 0.7         |

Se arriva una nuova email con le parole "**Gratis Offerta**", calcoliamo:  

\[
P(Spam | Gratis, Offerta) \propto P(Spam) \cdot P(Gratis | Spam) \cdot P(Offerta | Spam)
\]

\[
P(Non Spam | Gratis, Offerta) \propto P(Non Spam) \cdot P(Gratis | Non Spam) \cdot P(Offerta | Non Spam)
\]

Se la probabilità di Spam è maggiore, l'email sarà classificata come **Spam**.  

---

### **Conclusione**  
Il **Naïve Bayes** è veloce ed efficace, soprattutto per **testo e dati categoriali**, ma assume che le caratteristiche siano indipendenti, il che può non essere sempre vero.