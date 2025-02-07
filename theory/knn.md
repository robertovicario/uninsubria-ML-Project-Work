### **KNN Classifier - Spiegazione Semplice**  
Il **KNN (K-Nearest Neighbors) Classifier** è un algoritmo di **apprendimento supervisionato** utilizzato per classificare nuovi dati in base alla somiglianza con esempi già noti. Funziona in questo modo:  

1. **Memorizza i dati**: Non ha una fase di apprendimento vera e propria, ma conserva tutti gli esempi noti.  
2. **Trova i vicini più vicini**: Quando arriva un nuovo dato, misura la distanza da tutti i punti già conosciuti.  
3. **Assegna la classe**: Guarda le **K osservazioni più vicine** e assegna la classe più comune tra loro.  

Ad esempio, se vogliamo classificare un frutto tra **mela** e **pera**, il KNN confronta il frutto nuovo con quelli già classificati e assegna la categoria in base ai più vicini.  

---

### **Tipi di Distanza**  
Per trovare i vicini più vicini, il KNN usa diverse misure di distanza:  

1. **Distanza Euclidea** (Come una riga retta tra due punti)  
   \[
   d_E(A, B) = \sqrt{(x_2 - x_1)^2 + (y_2 - y_1)^2}
   \]
   Se vogliamo calcolare la distanza tra due città sulla mappa, questa misura è la distanza più corta.  

2. **Distanza Manhattan** (Come muoversi su una griglia)  
   \[
   d_M(A, B) = |x_2 - x_1| + |y_2 - y_1|
   \]
   Se immaginiamo un taxi in una città con strade a incroci, la distanza Manhattan è quella che segue le strade senza attraversare edifici.  

3. **Distanza di Chebyshev** (La distanza massima tra due coordinate)  
   \[
   d_C(A, B) = \max(|x_2 - x_1|, |y_2 - y_1|)
   \]
   È usata negli scacchi per misurare quanti passi servono a un re per raggiungere un’altra casella.  

---

### **Dimostrazione Matematica del KNN**  
Dato un insieme di **n** punti di addestramento \(\{(x_i, y_i)\}_{i=1}^{n}\), vogliamo classificare un nuovo punto \(\mathbf{x}\).  

1. **Troviamo la distanza** tra \(\mathbf{x}\) e tutti i punti noti usando una delle distanze viste sopra.  
2. **Selezioniamo i K punti più vicini**.  
3. **Assegniamo la classe più frequente** tra questi K punti.  
   \[
   \hat{y} = \arg\max_c \sum_{i \in N_k} \mathbf{1}(y_i = c)
   \]
   Dove \(N_k\) è l'insieme dei K punti più vicini e \(\mathbf{1}(y_i = c)\) vale 1 se il punto appartiene alla classe \(c\), altrimenti 0.  

---

### **Esempio Pratico**  
Immaginiamo di voler classificare un animale tra **gatto** e **cane** in base a due caratteristiche:  

| Animale  | Altezza (cm) | Peso (kg) | Classe |
|----------|-------------|-----------|--------|
| A        | 25          | 5         | Gatto  |
| B        | 60          | 20        | Cane   |
| C        | 22          | 4         | Gatto  |
| D        | 70          | 25        | Cane   |
| ? (Nuovo) | 30          | 6         | ???    |

Se scegliamo \(K=3\) e usiamo la **distanza Euclidea**, troviamo che il nuovo animale è più vicino ai **gatti** e quindi lo classifichiamo come **gatto**.  

---

### **Conclusione**  
Il **KNN Classifier** è semplice da implementare, ma può essere lento con molti dati. La scelta della distanza e del numero \(K\) influenza molto i risultati.