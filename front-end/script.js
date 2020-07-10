$(document).ready(function () {
    const $tbody = $("#tArticleList");
    const $table = $("#tListOfLists");
    const $select = $("#listCategories");

    const $articleInput = $("#itAddArticle");
    const $form = $("form");
    const URL = "http://localhost:3000/article/";
    const URL1 = "http://localhost:3000/list/";
    const URL2 = "http://localhost:3000/category/";
    const URL3 = "http://localhost:3000/article-list/";
    var idListSelected = 1


    function getTableRowArticles(line) {
        const $tr = $(`<tr >
            <td>${line.article_name}</td>
            <td>${line.category_name}</td>
            <td>
                <button class="delete btn btn-danger" data-id="${line.id}">Supprimer</button>    
            </td>
            </tr>`);

        return $tr;
    }

    function renderTableArticles(rows) {
        // supprimer les lignes existantes dans le tableau
        $tbody.empty()

        //boucle sur rows
        for (line of rows) {
            // Ajout de la ligne à tbody
            $tbody.append(getTableRowArticles(line));
        }
    }


    function getTableRowLists(line) {
        const $tr = $(`<tr listId="${line.id}">
            <td >${line.list_name}</td>
            <td>
                <button class="delete btn btn-danger" data-id="${line.id}">Supprimer</button>    
            </td>
            </tr>`);

        return $tr;
    }

    function renderTableLists(rows) {
        // supprimer les lignes existantes dans le tableau
        $table.empty()

        //boucle sur rows
        for (line of rows) {
            // Ajout de la ligne à tbody
            $table.append(getTableRowLists(line));
        }
        makeListsSelected()
    }
    function getTableRowCategories(line) {
        const $tr = $(`<option value="${line.id}">${line.category_name}</option>`);

        return $tr;
    }

    function renderSelectCategories(rows) {
        // supprimer les lignes existantes dans le tableau


        //boucle sur rows
        for (line of rows) {
            // Ajout de la ligne à tbody
            $select.append(getTableRowCategories(line));
        }
    }

    $form.submit(function (event) {
        // Empêcher le comportement par défaut
        event.preventDefault();

        // Récuperation de la saisie
        const article = $articleInput.val().trim();
        const categoryId = $select.val()
        const data = {
            name: article,
            categoryId: categoryId
        };
        // Traitement de la saisie si elle n'est pas vide

        if (article) {
            $.ajax({ url: URL + idListSelected, method: 'POST', data: JSON.stringify(data), contentType: "application/json; charset=utf-8", dataType: "json" })
                .done((res) => {
                    loadDataArticle()
                })
                .fail(function (err) {
                    console.log(err);
                })
        }
        
    });
    


    function loadDataArticle() {
        if (idListSelected == 1) {
            $.get(URL)
                .done(function (response) {
                    renderTableArticles(response);
                    // todo Afficher les données
                }).fail(function (err) {
                    console.log(err);
                });
        }
        else {
            $.get(URL3 + idListSelected)
                .done(function (response) {
                    renderTableArticles(response);
                    // todo Afficher les données
                }).fail(function (err) {
                    console.log(err);
                });
        }
        // Boutons supprimer
    $tbody.undelegate()
    $tbody.delegate('.delete', 'click', function () {
        // Récupération de l'id
        const id = $(this).data("id");
        console.log(id);
        // Requête du suppresion
        $.ajax({ url: URL + id +'/'+idListSelected, method: 'delete' })
            .done(function (response) {
                loadDataArticle();
            })
            .fail(function (err) {
                console.log(err);
            });
    });
    }
    function loadDataCategory() {


        $.get(URL1)
            .done(function (response) {
                renderTableLists(response);
                // todo Afficher les données
            }).fail(function (err) {
                console.log(err);
            });
    }
    function loadDataList() {

        $.get(URL2)
            .done(function (response) {
                renderSelectCategories(response);
                // todo Afficher les données
            }).fail(function (err) {
                console.log(err);
            });


    }
    function loadAllData(){
        loadDataArticle()
        loadDataCategory()
        loadDataList()
    }

    function makeListsSelected() {
        $("#tListOfLists tr").click(function () {
            $('.selected').removeClass('selected');
            if(idListSelected == $(this).attr('listId'))
            {
                idListSelected = 1
            }
            else{
                $(this).addClass("selected");
                idListSelected = $(this).attr('listId')
            }
            
            loadDataArticle()

        });
    }


    loadAllData();
});