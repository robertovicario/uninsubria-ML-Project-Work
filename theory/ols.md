### **OLS - Spiegazione Semplice**

L'**OLS (Ordinary Least Squares)** è un metodo statistico utilizzato per risolvere problemi di **regressione lineare**, cioè per prevedere un **valore continuo** (come il prezzo di una casa) a partire da un insieme di **variabili indipendenti** (ad esempio, la dimensione della casa, il numero di stanze, ecc.). 

L'idea principale di OLS è quella di **trovare la retta (o piano)** che meglio si adatta ai dati, minimizzando la somma dei **quadrati delle distanze** tra i punti osservati e i punti previsti dalla retta.

#### Formula di OLS:
Nel caso di regressione lineare semplice, la retta ha la forma:

\[
y = \beta_0 + \beta_1 x
\]

Dove:
- \( y \) è la variabile dipendente (ad esempio, il prezzo della casa),
- \( x \) è la variabile indipendente (ad esempio, la dimensione della casa),
- \( \beta_0 \) è l'intercetta (cioè il valore di \( y \) quando \( x = 0 \)),
- \( \beta_1 \) è il coefficiente che rappresenta l'effetto di \( x \) su \( y \).

OLS cerca i valori di \( \beta_0 \) e \( \beta_1 \) che minimizzano la **somma dei quadrati degli errori** (SSE), ovvero la differenza tra i valori osservati e quelli predetti.

---

### **Regolarizzazione in OLS: Ridge, LASSO, Elastic Net**

Quando si lavora con modelli di regressione, a volte è necessario **controllare la complessità del modello** per evitare il **sovradattamento** (overfitting). Questo è particolarmente utile quando ci sono molte variabili indipendenti o quando i dati sono rumorosi. I metodi di **regolarizzazione** aggiungono un termine alla funzione di costo per penalizzare la complessità del modello.

1. **Ridge Regression (L2 Regularization)**  
   La **regolarizzazione Ridge** aggiunge un termine alla funzione di costo che penalizza i **coefficienti grandi**. Questo aiuta a ridurre l'overfitting, ma non fa sparire i coefficienti completamente.  
   La formula della funzione di costo diventa:
   
   \[
   \text{Minimize} \quad \sum_{i=1}^{n} (y_i - \hat{y}_i)^2 + \lambda \sum_{j=1}^{p} \beta_j^2
   \]
   Dove:
   - \( \lambda \) è il parametro di regolarizzazione che controlla quanto deve essere forte la penalizzazione sui coefficienti,
   - \( \beta_j \) sono i coefficienti delle variabili indipendenti,
   - Il termine \( \sum_{j=1}^{p} \beta_j^2 \) è la penalizzazione L2.

   Ridge riduce i coefficienti, ma **non li annulla completamente**.

2. **LASSO (Least Absolute Shrinkage and Selection Operator) (L1 Regularization)**  
   La **regolarizzazione LASSO** aggiunge un termine che penalizza i **coefficienti assoluti**, con l'obiettivo di ridurre alcuni coefficienti a **zero**. Questo ha anche l'effetto di **selezionare** le variabili più rilevanti per il modello.
   
   La formula della funzione di costo diventa:
   
   \[
   \text{Minimize} \quad \sum_{i=1}^{n} (y_i - \hat{y}_i)^2 + \lambda \sum_{j=1}^{p} |\beta_j|
   \]
   Dove:
   - \( \lambda \) è il parametro di regolarizzazione,
   - \( \beta_j \) sono i coefficienti delle variabili indipendenti,
   - Il termine \( \sum_{j=1}^{p} |\beta_j| \) è la penalizzazione L1.

   LASSO tende a **portare alcuni coefficienti esattamente a zero**, il che significa che alcune variabili non vengono più utilizzate nel modello.

3. **Elastic Net**  
   L'**Elastic Net** è una combinazione di Ridge e LASSO. Utilizza sia la penalizzazione **L1** (di LASSO) che la penalizzazione **L2** (di Ridge). Questo è utile quando ci sono molte variabili correlate, poiché LASSO può selezionare solo una tra variabili altamente correlate, mentre Ridge può ridurre tutti i coefficienti ma non eliminarli completamente.
   
   La funzione di costo per Elastic Net è:
   
   \[
   \text{Minimize} \quad \sum_{i=1}^{n} (y_i - \hat{y}_i)^2 + \lambda_1 \sum_{j=1}^{p} |\beta_j| + \lambda_2 \sum_{j=1}^{p} \beta_j^2
   \]
   Dove:
   - \( \lambda_1 \) è il parametro di regolarizzazione per la penalizzazione L1 (LASSO),
   - \( \lambda_2 \) è il parametro di regolarizzazione per la penalizzazione L2 (Ridge).

   Elastic Net è molto utile quando i dati hanno **molte variabili correlate**.

---

### **Dimostrazione Matematica**  

1. **OLS**:  
   La **funzione di costo** di OLS (senza regolarizzazione) è:
   \[
   \text{SSE} = \sum_{i=1}^{n} (y_i - \hat{y}_i)^2
   \]
   Dove \( \hat{y}_i = \beta_0 + \beta_1 x_1 + \beta_2 x_2 + \cdots + \beta_p x_p \). L'obiettivo è **minimizzare** questa funzione, trovando i valori di \( \beta_0, \beta_1, ..., \beta_p \).

2. **Ridge**:  
   Aggiungiamo un termine L2 alla funzione di costo:
   \[
   \text{Cost} = \sum_{i=1}^{n} (y_i - \hat{y}_i)^2 + \lambda \sum_{j=1}^{p} \beta_j^2
   \]
   L'algoritmo trova i valori di \( \beta_j \) che minimizzano questa funzione, riducendo i coefficienti più grandi.

3. **LASSO**:  
   La funzione di costo con L1 è:
   \[
   \text{Cost} = \sum_{i=1}^{n} (y_i - \hat{y}_i)^2 + \lambda \sum_{j=1}^{p} |\beta_j|
   \]
   L'algoritmo riduce alcuni coefficienti a zero, selezionando le variabili più importanti.

4. **Elastic Net**:  
   La funzione di costo per Elastic Net è una combinazione di Ridge e LASSO:
   \[
   \text{Cost} = \sum_{i=1}^{n} (y_i - \hat{y}_i)^2 + \lambda_1 \sum_{j=1}^{p} |\beta_j| + \lambda_2 \sum_{j=1}^{p} \beta_j^2
   \]

---

### **Esempio Pratico**

Immagina di voler prevedere il **prezzo di una casa** (variabile dipendente \( y \)) in base a due caratteristiche: **superficie** della casa (\( x_1 \)) e **numero di stanze** (\( x_2 \)).

I dati di addestramento potrebbero essere simili a questo:

| Superficie (m²) | Stanze | Prezzo (€) |
|------------------|--------|------------|
| 100              | 3      | 150,000    |
| 120              | 4      | 180,000    |
| 150              | 4      | 200,000    |
| 80               | 2      | 130,000    |

Ora, utilizziamo **OLS** per trovare i coefficienti \( \beta_0 \), \( \beta_1 \), e \( \beta_2 \) che minimizzano la somma dei quadrati degli errori (SSE).

- Con **Ridge**: se i dati sono molto rumorosi o se ci sono molte caratteristiche, Ridge potrebbe essere usato per ridurre l'influenza di variabili non significative.
- Con **LASSO**: se vogliamo che alcune caratteristiche non influenzino affatto il prezzo (ad esempio, se il numero di stanze non ha rilevanza), LASSO può annullare quei coefficienti.
- Con **Elastic Net**: se abbiamo variabili correlate (ad esempio, superficie e stanze), l'Elastic Net può essere una buona scelta, combinando i benefici di Ridge e LASSO.

In questo modo, possiamo ottenere un modello di regressione che predice il **prezzo della casa** in modo più robusto e affidabile.