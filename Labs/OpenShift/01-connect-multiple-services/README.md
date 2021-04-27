<img src="../../../img/logo.png" alt="Chmurowisko logo" width="200"  align="right">
<br><br>
<br><br>
<br><br>

# Connect Services

## LAB Overview

W tym ćwiczeniu stworzysz aplikację składającą się z 3 usług (usługi frontend, backend API oraz bazy danych MongoDB). Aplikację udostępnisz dla świata zewnętrznego.

## Wymagania

1. Konto Github

## 1. Stwórz nowy projekt

1. Przejdź do perspektywy programisty
1. Rozwiń listę projektów
1. Dodaj nowy projekt "Create project"
1. Nazwij projekt w formacie `<login_konta_aad>-ratings`, gdzie w `<login_konta_aad>` wstawisz login użytkownika z konta AAD, np. dla `cmstudent99@chmurowiskolab.onmicrosoft.com` wstaw `cmstudent99`.

![](./img/01-create-new-project.png)

## 2. Dodaj nowy template dla usługi MongoDB

1. Otwórz plik [`./files/mongodb-persistent.json`](./files/mongodb-persistent.json) ([link](<(./files/mongodb-persistent.json)>)) i skopiuj jego zawartość
1. Przejdź do OpenShift i na główny ekranie kliknij przycisk pokazany na poniższym zrzucie:

   ![](./img/02-add-yaml.png)

1. Na nowym ekranie wklej zawartość pliku i kliknij "Create"

   ![](./img/03-add-yaml.png)

1. W rezultacie powinnaś/powinieneś otrzymać widok podobny do poniższego:

   ![](./img/04-new-template-success.png)

## 3. Stwórz nową usługę MongoDB

1. Przejdź do "+Add", wybierz opcję "From Catalog"

   ![](./img/05-from-catalog.png)

1. Znajdź usługę o nazwie: MongoDB (możesz użyć wyszukiwarki)

   ![](./img/06-filter-catalog.png)

1. W panelu który pojawił się z boku ekranu wybierz "Instantiate Template"
1. Podaj następujące wartości

   | Pole                        | Wartość         |
   | --------------------------- | --------------- |
   | Database Service Name       | mongodb         |
   | MongoDB Connection Username | ratingsuser     |
   | MongoDB Connection Password | ratingspassword |
   | MongoDB Database Name       | ratingsdb       |
   | MongoDB Admin Password      | ratingspassword |

   ![](./img/07-instantiate-mongodb.png)

## 4. Wdróż usługę Rating API

1. Przejdź do repozytorium [`microsoft/rating-api`](https://github.com/microsoft/rating-api) ([link](https://github.com/microsoft/rating-api))
1. Sforkuj aplikację do swojego repozytorium (musisz być zalogowany do swojego konta Github)

   ![](./img/08-fork-ratings-api.png)

1. Przejdź do OpenShift, wybierz "+Add" i opcję "From Git".
1. Wklej link do sforkowanego repozytorium. **Nie klikaj od razu przycisku "Create"**.
1. W sekcji "Advanced Options" **odznacz** opcję "Create a route to the application".

   ![](./img/09-disable-create-route.png)

1. Rozwiń sekcję "Build Configuration"

   ![](./img/10-build-configuration.png)

1. Ustaw zmienną środowiskową o nazwie `MONGODB_URI`. **Uwaga! W linku zmień `<nazwa_projektu>` na właściwą nazwę swojego projektu**

   | Nazwa       | Wartość                                                                                          |
   | ----------- | ------------------------------------------------------------------------------------------------ |
   | MONGODB_URI | mongodb://ratingsuser:ratingspassword@mongodb.<nazwa_projektu>.svc.cluster.local:27017/ratingsdb |

1. Kliknij przycisk "Create"

   ![](./img/11-ratings-api.png)

## 5. Ustaw Github Webhook dla zmian w repozytorium Rating API

1. Przejdź do perspektywy Administratora, wybierz _Build_ > _Build Configs_. Wybierz Build Config o nazwie: "rating-api". Skopiuj adres Webhook dla Github za pomocą "Copy URL with Secret".
1. Przejdź do sforkowanego repozytorium
1. Przejdź do zakładki _Settings_ > _Webhooks_ > _Add webhook_
1. Wklej skopiowany adres URL do pola "Payload URL" oraz zmień "Content type" na `application/json`. Zapisz Webhook klikając "Add webhook".

## 6. Wdróż usługę Ratings Web

1. Przejdź do repozytorium [`microsoft/rating-web`](https://github.com/microsoft/rating-web) ([link](https://github.com/microsoft/rating-web))
1. Sforkuj aplikację do swojego repozytorium (musisz być zalogowany do swojego konta Github)
1. Przejdź do OpenShift, wybierz "+Add" i opcję "From Git".
1. Wklej link do sforkowanego repozytorium. **Nie klikaj od razu przycisku "Create"**.
1. Rozwiń sekcję "Build Configuration"
1. Ustaw zmienną środowiskową o nazwie `API`

   | Nazwa | Wartość                |
   | ----- | ---------------------- |
   | API   | http://rating-api:8080 |

1. Kliknij przycisk "Create"

   ![](./img/11-ratings-api.png)

## 7. Ustaw Github Webhook dla zmian w repozytorium Rating Frontend

1. Przejdź do perspektywy Administratora, wybierz _Build_ > _Build Configs_. Wybierz Build Config o nazwie: "rating-web". Skopiuj adres Webhook dla Github za pomocą "Copy URL with Secret".
1. Przejdź do sforkowanego repozytorium
1. Przejdź do zakładki _Settings_ > _Webhooks_ > _Add webhook_
1. Wklej skopiowany adres URL do pola "Payload URL" oraz zmień "Content type" na `application/json`. Zapisz Webhook klikając "Add webhook".

## 8. Wykonaj zmianę w kodzie i zobacz jak przebudowywane są usługi

1. Przejdź do sforkowanego repozytorium aplikacji `rating-web`.
1. Wyświetl zawartość folderu `/src`

   ![](./img/12-src-directory.png)

1. Otwórz plik `App.vue`
1. Zmień wartość `background-color` w 22 linii (zakomentuj/odkomentuj linie obok siebie)

   ![](./img/13-make-a-change.png)

1. Sprawdź czy kolor tła został zmieniony (możesz wyświetlić stronę w trybie Incognito):

   ![](./img/14-result-1.png)
   ![](./img/15-result-2.png)

## END LAB

<br><br>

<center><p>&copy; 2021 Chmurowisko Sp. z o.o.<p></center>
