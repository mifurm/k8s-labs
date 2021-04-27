<img src="../../../img/logo.png" alt="Chmurowisko logo" width="200"  align="right">
<br><br>
<br><br>
<br><br>

# OpenShift Labs

## LAB Overview

W tym ćwiczeniu wdrożysz testowy projekt ["OSToy"](https://github.com/openshift-cs/ostoy) (stworzony przez [OpenShift Customer Success](https://github.com/openshift-cs)) i zobaczysz w jaki sposób w OpenShift skalować aplikacje ręcznie oraz automatycznie.

## Wymagania

1. Ukończenie lab `02-view-pod-logging`

## 1. Zwiększ ręcznie liczbę replik

1. Przejdź do aplikacji OSToy i wyświetl widok "Networking". Zwróć uwagę ile _Remote Pods_ jest w tym momencie wyświetlanych.
1. Przejdź do perspektywy Administratora. Wyświetl listę _Deployments_ i wybierz `ostoy-microservice`.
1. Zwiększ liczbę replik do 3.
1. Przejdź do aplikacji OSToy i wyświetl widok "Networking". Liczba _Remote Pods_ powinna ulec zmianie.
1. Zmniejsz liczbę replik do 1 (żeby w kolejnym kroku łatwo zaobserwować autoscaling)

## 2. Skonfiguruj Horizontal Pod Autoscaler

> Według dokumentacji _Horizontal Pod Autoscaler_ automatycznie skaluje liczbę Pod na podstawie wykorzystania CPU

1. Przejdź do perspektywy Administratora. Wyświetl _"Horizontal Pod Autoscalers"_. Kliknij _"Create Horizontal Pod Autoscaler"_.
1. Zmodyfikuj wyświetlony YAML:

   - zmień nazwę (`name`) w sekcji `scaleTargetRef` na `ostoy-microservice`
   - zmień wartość `averageUtilization` na `10`

1. Sprawdź w jaki sposób zmienił się UI Deploymentu `ostoy-microservice`

## 3. Zwiększ wykorzystanie CPU

1. Przejdź do aplikacji OSToy. Wyświetl widok "Auto Scaling".
1. Przeczytaj instrukcję i zwiększ zużycie CPU.
1. Przejdź do OpenShift. Wyświetl _Deployment_ `ostoy-microservice`.
1. Poczekaj 1 minutę.
1. Zobacz jak liczba Pod została zwiększona automatycznie.

## 4. Zaobserwuj działanie _autoscaling_ w przypadku braku wysokiego wykorzystania CPU

1. Przejdź do OpenShift. Wyświetl _Deployment_ `ostoy-microservice`. Możesz zamknąć kartę z aplikacją OSToy.
1. Poczekaj 2-3 minuty.
1. Zauważ jak zmieniła się liczba Pod.

## 5. Sprawdź adres IP usługi podając jej nazwę DNS

1. Przejdź do perspektywy Administratora. Wyświetl listę _Services_. Skopiuj nazwę dowolnego _Service_ w tym projekcie.
1. Przejdź do aplikacji OSToy i wyświetl widok "Networking".
1. Uzupełnij pole `Hostname` w sekcji _"Hostname Lookup"_ nazwą wybranego Service. Kliknij _"DNS Lookup"_.
1. Sprawdź czy wyświetlone IP zgadza się z ClusterIP w szczegółach _Service_.

## END LAB

<br><br>

<center><p>&copy; 2021 Chmurowisko Sp. z o.o.<p></center>
