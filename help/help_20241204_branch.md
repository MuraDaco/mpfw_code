
- creare un nuovo branch collegato con la repository remota
    - quello su github si potrebbe usare di defaut il branch "main"
    - N.B.: quando si rimuove una repository remota con il comando
        - $ git remote remove origin <url repository>
        - si perdono tutti i riferimenti ai branch presenti nella repository remota
            - per ripristinarli è sufficente eseguire il comando 
                - $ git fetch 

- come avere nella repository remota un branch "pulito" senza i commit intermedi degli altri branch che sono stati incorporatri attraverso l'operazione di mmerge?
    - questo permetterebbe di avbere su un unica reposiotry locale tutti i branch di lavoro e anche il branch remoto/pubblico pulito

rsync -nav /Users/work/ObsiData/github_test/mpfw/code/mpfw_code/main/mpfw_code_main_stm_20230420 .