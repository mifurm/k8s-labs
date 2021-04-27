<img src="../../../img/logo.png" alt="Chmurowisko logo" width="200"  align="right">
<br><br>
<br><br>
<br><br>

# OpenShift Labs

## LAB Overview

W tym ćwiczeniu wdrożysz testowy projekt ["OSToy"](https://github.com/openshift-cs/ostoy) (stworzony przez [OpenShift Customer Success](https://github.com/openshift-cs)) i zobaczysz w jaki sposób OpenShift używa Persistent Storage.

## Wymagania

1. Ukończenie lab `02-view-pod-logging`

## 1. Wyświetl _Persistent Volume Claim_

1. Przejdź do perspektywy Administratora
1. Przejdź do Storage > Persistent Volume Claims
1. Zapoznaj się ze szczegółami zasobu
1. Sprawdź w [dokumentacji OpenShift](https://docs.openshift.com/container-platform/4.6/storage/understanding-persistent-storage.html#pv-access-modes_understanding-persistent-storage) czym charakteryzuje się przypisany do Claim _Access Mode_

## 2. Dodaj plik do Persistent Storage

1. Przejdź do aplikacji OSToy. Przejdź do widoku _"Persistent Storage"_
1. Dodaj nowy plik za pomocą formularza. Nazwa i treść są dowolne
1. Upewnij się, że plik pojawia się na liście _"Existing files"_

## 3. Wyświetl plik w terminalu pod

1. Przejdź do Deployment _"ostoy-frontend"_. Wyświetl zakładkę _"Pods"_.
1. Wybierz Pod inny niż widoczny w aplikacji

   ![](./img/01-different-pod.png)

1. Przejdź do zakładki "Terminal" i wywołaj kolejno poniższe komendy. Upewnij się, że treść pliku wpisana programem `cat` jest poprawna.

   ```shell
   ls
   ```

   ```shell
   ls /var
   ```

   ```shell
   ls /var/demo_files
   ```

   (w folderze `/var/demo_files` przechowywany jest dodany z aplikacji OSToy plik)

   ```shell
   cat /var/demo_files/<tu_podaj_nazwe_pliku>
   ```

   ![](./img/02-pod-terminal.png)

## 3. Zmniejsz liczbę replik do 0

> W tym kroku chcemy zniszczyć wszystkie dotychczas dostępne Pod, żeby sprawdzić nieulotność plików Persistent Storage.

1. Przejdź do Deployment _"ostoy-frontend"_ i zmniejsz liczbę replik do 0

## 4. Powiększ liczbę replik do 1

> W tym kroku chcemy stworzyć nowy Pod i upewnić się, że wyświetli dodany w 2. kroku plik

1. Przejdź do Deployment _"ostoy-frontend"_ i zwiększ liczbę replik do 1

## 5. Wyświetl plik dodany w kroku 2.

1. Przejdź do aplikacji OSToy. Wyświetl widok _"Persistent Storage"_.
1. Upewnij się, że na liście _"Existing files"_ istnieje plik dodany w 2. kroku
1. Upewnij się, że treść pliku jest poprawna

## END LAB

<br><br>

<center><p>&copy; 2021 Chmurowisko Sp. z o.o.<p></center>
