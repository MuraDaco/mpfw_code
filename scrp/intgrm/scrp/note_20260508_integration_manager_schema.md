
---

Wed 10 Jun 2026 17:23:01 CEST

- esempi reali
    - mpfw_fw2-main-app20250424-5main
        - ./repos_sync.sh --scn-intgrm reale --ws-intgrm github_20260601 --publc "https://github.com/MuraDaco/mpfw_fw2-main-app20250424-5main.git" --dvlpr "file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/mpfw_fw2-main-app20250424-5main.git" --rel-name  Update_First_Release --rel-null 1 3 --rel-inc 2
        - ./repos_sync.sh --scn-intgrm reale --ws-intgrm github_20260601 --env-intgrm mpfw_fw2-main-app20250424-5main git:push
        - ./repos_sync.sh --scn-intgrm reale --ws-intgrm github_20260601 --env-intgrm mpfw_fw2-main-app20250424-5main git:log
    - mpfw_fw2_cmake
        - ./repos_sync.sh --scn-intgrm reale --ws-intgrm github_20260601 --publc "https://github.com/MuraDaco/mpfw_fw2_cmake.git" --dvlpr "file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/mpfw_fw2_cmake.git" --rel-name  Update_First_Release --rel-null 1 3 --rel-inc 2
        - ./repos_sync.sh --scn-intgrm reale --ws-intgrm github_20260601 --env-intgrm mpfw_fw2_cmake git:push
        - ./repos_sync.sh --scn-intgrm reale --ws-intgrm github_20260601 --env-intgrm mpfw_fw2_cmake git:log
    - mpfw_code
        - ./repos_sync.sh --scn-intgrm reale --ws-intgrm github_20260601 --publc "https://github.com/MuraDaco/mpfw_code.git" --dvlpr "file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/mpfw_code.git" --rel-name  Update_First_Release --rel-null 1 3 --rel-inc 2
        - ./repos_sync.sh --scn-intgrm reale --ws-intgrm github_20260601 --env-intgrm mpfw_code git:push
        - ./repos_sync.sh --scn-intgrm reale --ws-intgrm github_20260601 --env-intgrm mpfw_code git:log

---

Mon  1 Jun 2026 05:14:24 CEST


- comandi da dare per creare un ambiente di test
    - N.B.: creare l'ambiente di test significa
        - creare le reposiotries dello sviluppatore
            - le repositories di lavoro
                - necessarie per creare le reposiotries remote pubbliche
            - le repositories remote pubbliche 
                - quelle a cui fanno riferimento le repositories di lavoro dell'integration manager
        - per maggiori dettagli sui comandi vedere "console_20260531_test_env.txt" ed in particolare il giorno 28 maggio
    - work@umtiefs-Mac-mini scrp % ./repos_sync.sh --env-dvlpr-remote test_dvlpr_remote_repos modulo_test_20260528_A
        - Initialized empty Git repository in /Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/developer/[test_dvlpr_remote_repos]/[modulo_test_20260528_A].git/
        - crea la repository remota dello sviluppatore per il modulo [modulo_test_20260528_A]
    - work@umtiefs-Mac-mini scrp % ./repos_sync.sh --env-dvlpr dvlpr3_ws4 modulo_test_20260528_A 
        - Initialized empty Git repository in /Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_1/developers/[dvlpr3_ws4]/[modulo_test_20260528_A]/.git/
        - crea la repository di lavoro dello sviluppatore per il modulo [modulo_test_20260528_A]
    - work@umtiefs-Mac-mini scrp % ./repos_sync.sh --env-dvlpr dvlpr3_ws4 modulo_test_20260528_A git:remote
        - mostra le repository remote configurate nella repository di lavoro dello sviluppatore
    - work@umtiefs-Mac-mini scrp % ./repos_sync.sh --env-dvlpr dvlpr3_ws4 modulo_test_20260528_A remote_config:test_dvlpr_remote_repos
        - performing 'git remote add my_public_repo "file:///Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/developer/test_dvlpr_remote_repos/modulo_test_20260528_A.git"' command
        - configura la reposiotry remota nella repository di lavoro dello sviluppatore
    - work@umtiefs-Mac-mini scrp % ./repos_sync.sh --env-dvlpr dvlpr3_ws4 modulo_test_20260528_A new_files                            
        - crea un nuovo file nella repository di lavoro dello sviluppatore per simulare le attività di sviluppo di quest'ultimo
    - work@umtiefs-Mac-mini scrp % ./repos_sync.sh --env-dvlpr dvlpr3_ws4 modulo_test_20260528_A git:log
        - mostra il log dei commit, viene eseguito il seguente comando
            - git log --pretty=oneline --decorate --graph --all        
        - INFO - performing 'git log' command
    - work@umtiefs-Mac-mini scrp % ./repos_sync.sh --env-dvlpr dvlpr3_ws4 modulo_test_20260528_A git:status 
        - INFO - performing 'git status' command
    - work@umtiefs-Mac-mini scrp % ./repos_sync.sh --env-dvlpr dvlpr3_ws4 modulo_test_20260528_A git:commit:First_commit
        - INFO - performing 'git commit' command
    - work@umtiefs-Mac-mini scrp % ./repos_sync.sh --env-dvlpr dvlpr3_ws4 modulo_test_20260528_A git:push:set-upstream
        - questo comando deve essere dato solo la prima volta che si esegue il commit dopo aver configurato la repository remota
        - INFO - performing 'git push --set-upstream my_public_repo main' command
    - work@umtiefs-Mac-mini scrp % ./repos_sync.sh --env-dvlpr dvlpr3_ws4 modulo_test_20260528_A upd_files              
        - INFO - updating new files & committing them
    - work@umtiefs-Mac-mini scrp % ./repos_sync.sh --env-dvlpr dvlpr3_ws4 modulo_test_20260528_A git:commit:Second_commit
        - INFO - performing 'git commit' command
    - work@umtiefs-Mac-mini scrp % ./repos_sync.sh --env-dvlpr dvlpr3_ws4 modulo_test_20260528_A git:push                
        - INFO - performing 'git push' command
- comandi per sincronmizzare
    - scenario di test
        - N.B.: per questo scenario è necessario creare l'ambiente di test, che consiste nel creare le repositories di lavoro dello sviluppatore, per poter generare le repositories remote dello sviluppatore che sono un parametro essenziale per il comando [./repos_sync.sh]
        - work@umtiefs-Mac-mini scrp % ./repos_sync.sh --scn-intgrm 1 --ws-intgrm ws3 --publc "file:///Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/public/https/test_remote_1/modulo_test_20260528_A.git" --dvlpr "file:///Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/developer/test_dvlpr_remote_repos/modulo_test_20260528_A.git" --rel-name Test_First_Release --rel-null 1 3 --rel-inc 2
        - work@umtiefs-Mac-mini scrp % ./repos_sync.sh --scn-intgrm 1 --ws-intgrm ws3 --env-intgrm modulo_test_20260528_A git:log
            - mostra il log della repository dell'integration manager
        - work@umtiefs-Mac-mini scrp % ./repos_list_sync2.sh --public-intgrm test 1 ws3 test_remote_1 --public-dvlpr test 1 test_dvlpr_remote_repos --create-local-public-repos --rel-name Test_First_Release --rel-null 1 3  --rel-inc 2 --range-down 0 --range-up 2
        - work@umtiefs-Mac-mini scrp % ./repos_list_sync2.sh --public-intgrm test 1 ws3 --public-dvlpr test --push --range-down 0 --range-up 2
    - scenario reale parziale
        - N.B.: in questo caso non è stato necessario creare l'ambiente di test dal momento che vengono utilizzate le repository pubbliche dello sviluppatore vere/reali
        - work@umtiefs-Mac-mini scrp % ./repos_list_sync2.sh --public-intgrm <test> [reale] [test4] [test_AAA] --public-dvlpr <reale> --rel-name Test_First_Release --rel-null 1 3  --rel-inc 2 --range-down 0 --range-up 2
            - work@umtiefs-Mac-mini scrp % ./repos_sync.sh --scn-intgrm [reale] --ws-intgrm [test4] --publc "file:///Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_[reale]/remote/public/https/[test_AAA]/<item in the range>.git" --dvlpr "file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/<item in the range>.git" --rel-name Test_First_Release --rel-null 1 3 --rel-inc 2
                - il path delle repository di lavoro dell'integration manager sarà
                    - "/Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_[reale]/manager/intgrm_[test4]"
                - ./repos_sync.sh --scn-intgrm reale --ws-intgrm test4 --publc "file:///Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_reale/remote/public/https/test_AAA/mpfw_code_main_stm_20230420.git" --dvlpr "file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/mpfw_code_main_stm_20230420.git" --rel-name Test_First_Release --rel-null 1 3 --rel-inc 2
                - ./repos_sync.sh --scn-intgrm reale --ws-intgrm test4 --env-intgrm mpfw_code_main_stm_20230420 git:log
                - ./repos_sync.sh --scn-intgrm reale --ws-intgrm test4 --env-intgrm mpfw_code_main_stm_20230420 git:push:set-upstream
                - ./repos_list_sync2.sh --public-intgrm test reale test4 test_AAA --public-dvlpr reale --create-local-public-repos --rel-name Test_First_Release --rel-null 1 3  --rel-inc 2 --range-down 0 --range-up 2
                    - create_local_public_repos questa opzione generà la repository pubblica dell'integration manager dato che lo scenario per l'integration manager è di test
                - ./repos_list_sync2.sh --public-intgrm test reale test4 --public-dvlpr reale --command push --range-down 0 --range-up 2
                    - ./repos_sync.sh --scn-intgrm reale --ws-intgrm test4 --env-intgrm <item inside list> git:push
                - ./repos_list_sync2.sh --public-intgrm test reale test4 --public-dvlpr reale --command log --range-down 0 --range-up 2
    - scenario reale totale
        - work@umtiefs-Mac-mini scrp % ./repos_list_sync2.sh --public-intgrm <reale> [reale] [github_20260601] --public-dvlpr <reale> --rel-name Update_First_Release --rel-null 1 3  --rel-inc 2 --range-down 0 --range-up 2
            - ./repos_list_sync2.sh --public-intgrm reale reale github_20260601 --public-dvlpr reale --rel-name Update_First_Release --rel-null 1 3  --rel-inc 2 --range-down 0 --range-up 2
            - ./repos_list_sync2.sh --public-intgrm reale reale github_20260601 --public-dvlpr reale --command push --range-down 0 --range-up 2

---

Thu 28 May 2026 14:50:04 CEST


- ./repos_list_sync2.sh --public-intgrm test [1] [ws3] [test_remote_1] --public-dvlpr test [1] [test_dvlpr_remote_repos] --create-local-public-repos --rel-name Test_First_Release --rel-null 1 3  --rel-inc 2 --range-down 0 --range-up 2
    - [IMPORTANTE] prima di eseguire questo comando si devono creare i moduli fittizi di test nella root directory delle repository pubbliche dello sviluppatore
        - le directories interessate saranno 3 (integration manager ws_repo & remota_repo, developer remota_repo)  + 1 (developer ws_repo)
            - le tre directory gestite/usate nel comando ./repos_list_sync2.sh saranno, in base ai parametri dati allo script:
                - [<integration manager ws_repo>]       -> /$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_[1]/manager/intgrm_[ws3]
                    - questo path viene generato dallo script [./repos_sync.sh] attraverso i parametri secondo ([1]) e terzo ([ws3]) dell'opzione --public-intgrm
                    - [IMPORTANTE] il secondo parametro dell'opzione --public-intgrm può assumere solo i valori di [1] e [reale], 
                        - si rammenta che questo parametro indica il path dello scenario ovvero il nome della folder sarà [scenario_1] o [scenario_reale]
                - [<integration manager remota_repo>]   -> /$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_[1]/remote/public/https/[test_remote_1]
                - [<developer remota_repo>]             -> /$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_[1]/remote/developer/[test_dvlpr_remote_repos]
            - la directory che simula l'archivio delle repositories di lavoro dello sviluppatore
                - [<developer ws_repo>]                 -> /$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/developers/[dvlpr3_ws4]
                    - N.B.: questa direectory non viene gestita dallo script [./repos_list_sync2.sh] ne in modo diretto ne in modo indiretto (via ./repos_sync.sh) vie utilizzata solo nelle procedure per simulare le repository dello sviluppatore, quindi il parametro [dvlpr3_ws4], come già appena scritto per il path della repostory ad esso associato, non viene usato dalllo script [./repos_list_sync2.sh]
                        - il parametro [dvlpr3_ws4] vien usato nello script [./repos_sync.sh] per eseguire le procedure che simulano le attivita dello sviluppatore, vedere appena sotto per i dettagli
    - questo comando per eseguire la syncronizzazione chiamerà lo script [./repos_sync.sh] con i seguenti parametri
        - ./repos_sync.sh 
            - --scn-intgrm [1] 
            - --ws-intgrm [ws3] 
            - --publc "file://<integration manager remota_repo>/<item inside range>"
            - --dvlpr "file://<developer remota_repo>/<item inside range>"
            - --rel-name [Test_First_Release] 
            - --rel-null 1 3  
            - --rel-inc 2
        - esempio
            - ./repos_sync.sh --scn-intgrm 1 --ws-intgrm ws3 --publc "file:///Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/public/https/test_remote_1/modulo_test_20260528_A.git" --dvlpr "file:///Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/developer/test_dvlpr_remote_repos/modulo_test_20260528_A.git" --rel-name Test_First_Release --rel-null 1 3 --rel-inc 2
            - [IMPORTANTE] dopo aver eseguito questo comando per controllare che tutto sia stato fatto si possono eseguire i seguienti comandi
                - ./repos_sync.sh --scn-intgrm 1 --ws-intgrm ws3 --env-intgrm modulo_test_20260528_A git:log
    - N.B.: il parametro [ws3] come si vede non compare direttamente nel path delle repostories inserite nella linea di comando, 
        - tuttavia questo parametro insieme al parametro [1] dell'opzione [--scn-intgrm] permette di ottenere il path alla directory root dove sono localizzate le repository di lavoro dell'integration manager
        - i primi parametri delle opzioni [--public-intgrm] e [--public-dvlpr] sono necesssari per ottenere il path completo delle repository associate alle opzioni [--publc] e [--dvlpr] dello script [./repos_sync.sh]; questi parametri possono assumere solo due valori ["test"] e ["reale"]
        - per chiarezza facciamo notare che nei casi
            - --public-intgrm [reale]:
                - [<integration manager remota_repo>]   -> github.com/MuraDaco
                N.B.: nel caso [reale] l'opzione --public-intgrm ha tre parametri invece dei quattro del caso [test]
            - --public-dvlpr [reale]:
                - [<developer remota_repo>]             -> /Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs
                N.B.: nel caso [reale] l'opzione --public-dvlpr ha solo un parametro
    - N.B.: questo script affinchè abbia successo ha bisogno solo dell'esistenza della repository pubblica dello sviluppatore
        - quindi l'opzione
        - --dvlpr "file://<developer remota_repo>/<item inside range>"
        - deve avere come parametro una repository esistente
        - al contrario la repository pubblica dell'integration manager se non esiste con l'opzione [--create-local-public-repos], nello scenario di [test] dell'integration manager, viene creata (nello scenario reale la creazione deve essere fatta a mano quindi collegandosi al proprio account github); 
        - N.B.: [IMPORTANTE] da tenere a mente che la creazione della repository pubblica dell'integration manager nel caso di test viene creata direttamente dallo script [./repos_list_sync2.sh] e non dallo script [./repos_sync.sh].
            - ho fatto un aggiornamento al codice dello script [./repos_sync.sh] e adesso (fri, 29/05/2026 16:20) anche lui crea la repository remota del intgrm nel caso non esistesse, ma solo nel caso che il protocollo associato al path sia [file://].
    - comandi per creare l'ambiente di test (si userà lo script [./repos_sync.sh] con delle opportune opzioni)
        - [IMPORTANTE] al momento il path delle reposiotries remote e di lavoro dello sviluppatore nel caso delle opzioni
            - --env-dvlpr
            - --env-dvlpr-remote
            - è forzato ad iniziare come <path developer scenario begin>="$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1" 
        - N.B.: vedere il file di log "console_20260528_test_env.txt"
        - questi comandi semplificano le seguentio attività
            - <creazione> reposiotries dello sviluppatore
                - di lavoro
                    - --env-dvlpr [dvlpr3_ws4] <item>
                        - N.B.: la directory "/<path developer scenario begin>/developers/[dvlpr3_ws4]" deve essere creata a mano altrimenti si avra un errore
                        - ./repos_sync.sh --env-dvlpr dvlpr3_ws4 modulo_test_20260528_A
                            - crea una repository di lavoro al path "/<path developer scenario begin>/developers/[dvlpr3_ws4]/modulo_test_20260528_A"
                - e remota
                    - --env-dvlpr-remote [test_dvlpr_remote_repos] <item>
                        - N.B.: la directory "/<path developer scenario begin>/remote/developer/[test_dvlpr_remote_repos]" deve essere creata a mano altrimenti si avra un errore
                        - <item> indica il nome della repository del modulo quindi il path della repository remota delmodulo sarà
                            - /<path developer scenario begin>/remote/developer/[test_dvlpr_remote_repos]/<item>
                    - ./repos_sync.sh --env-dvlpr-remote test_dvlpr_remote_repos modulo_test_20260528_A
                        - crea una "bare" repository al path "/<path developer scenario begin>/remote/developer/[test_dvlpr_remote_repos]/modulo_test_20260528_A.git"
            - <configuration> remote repo 
                - --env-dvlpr [dvlpr3_ws4] <item> remote_config:[test_dvlpr_remote_repos]
                    - ./repos_sync.sh --env-dvlpr dvlpr3_ws4 modulo_test_20260528_A remote_config:test_dvlpr_remote_repos
            - <mostra> la lista delle repo remote configurate
                - --env-dvlpr [dvlpr3_ws4] <item> remote
                    - ./repos_sync.sh --env-dvlpr dvlpr3_ws4 modulo_test_20260528_A git:remote
            - <status> della repository di lavoro
                - --env-dvlpr [dvlpr3_ws4] <item> git:status
            - <add> delle modifiche al codice
                - --env-dvlpr [dvlpr3_ws4] <item> git:add
            - <commit> delle modifiche al codice
                - --env-dvlpr [dvlpr3_ws4] <item> git:commit
                - --env-dvlpr [dvlpr3_ws4] <item> git:commit "<messaggio di commit>"
            - <push> dei nuovi commit dalla roeposiotry di lavoro a quella 
                - --env-dvlpr [dvlpr3_ws4] <item> git:push
            - <log> dello storico dei commit
                - --env-dvlpr [dvlpr3_ws4] <item> git:log
            - <creazione> nuovi file di codice
                - --env-dvlpr [dvlpr3_ws4] <item> new_files
            - <update> file di codice
                - --env-dvlpr [dvlpr3_ws4] <item> upd_files
                - --env-dvlpr [dvlpr3_ws4] <item> upd_files:commit
                - --env-dvlpr [dvlpr3_ws4] <item> upd_files:commit:<messaggio di commit>
                - --env-dvlpr [dvlpr3_ws4] <item> upd_files:commit:<messaggio di commit>:push
    - per controllare l'operato del comando si puo' eseguire il log della repository di lavoro dell'integfration manager
    - per far questo senza spostarsi nella repository deldi uno dei modulio creati si può dare il seguente comando
        - ./repos_sync.sh --scn-intgrm 1 --ws-intgrm ws3 --env-intgrm <item inside range> git:log
            - ad esempio
                - ./repos_sync.sh --scn-intgrm 1 --ws-intgrm ws3 --env-intgrm modulo_test_20260528_A git:log
    - esecuzione del comando
        - ./repos_list_sync2.sh --public-intgrm test 1 ws3 test_remote_1 --public-dvlpr test 1 test_dvlpr_remote_repos --create-local-public-repos --rel-name Test_First_Release --rel-null 1 3  --rel-inc 2 --range-down 0 --range-up 2

        - ./repos_sync.sh --scn-intgrm 1 --ws-intgrm ws3 --publc "file:///Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/public/https/test_remote_1/modulo_test_20260528_A.git" --dvlpr "file:///Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/developer/test_dvlpr_remote_repos/modulo_test_20260528_A.git" --rel-name Test_First_Release --rel-null 1 3 --rel-inc 2

        - ./repos_list_sync2.sh --public-intgrm test [1] [ws3] --public-dvlpr test --push --range-down 0 --range-up 2
            - ./repos_list_sync2.sh --public-intgrm test 1 ws3 --public-dvlpr test --push --range-down 0 --range-up 2
                - ./repos_sync.sh --scn-intgrm 1 --ws-intgrm ws3 --env-intgrm <item inside list> git:push

---

Wed 27 May 2026 14:00:17 CEST

- esecuzione task
    - creare una nuova repository per il caso reale
        - modulo: mpfw_code_apps_tst_20230703app
            - url: https://github.com/MuraDaco/mpfw_code_apps_tst_20230703app
            - url repository pubblica IntgrM:       https://github.com/MuraDaco/mpfw_code_apps_tst_20230703app.git
            - url repository pubblica Developer:    file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/mpfw_code_apps_tst_20230703app.git
            - comando di syncro:
                - ./repos_sync.sh --scn-intgrm reale --ws-intgrm github_2 --publc "https://github.com/MuraDaco/mpfw_code_apps_tst_20230703app.git" --dvlpr "file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/mpfw_code_apps_tst_20230703app.git" --rel-name Update_First_Release --rel-inc 2
                - ./repos_sync.sh --scn-intgrm reale --ws-intgrm github_2 --env-intgrm mpfw_code_apps_tst_20230703app git:status
                - ./repos_sync.sh --scn-intgrm reale --ws-intgrm github_2 --env-intgrm mpfw_code_apps_tst_20230703app git:log
        - modulo: mpfw_fw2-main-app20240619_new_bis-5main
            - url: https://github.com/MuraDaco/mpfw_fw2-main-app20240619_new_bis-5main
            - url repository pubblica IntgrM:       https://github.com/MuraDaco/mpfw_fw2-main-app20240619_new_bis-5main.git
            - url repository pubblica Developer:    file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/mpfw_fw2-main-app20240619_new_bis-5main.git
            - comando di syncro:
                - ./repos_sync.sh --scn-intgrm reale --ws-intgrm github_2 --publc "https://github.com/MuraDaco/mpfw_fw2-main-app20240619_new_bis-5main.git" --dvlpr "file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/mpfw_fw2-main-app20240619_new_bis-5main.git" --rel-name Update_First_Release --rel-inc 2
                - ./repos_sync.sh --scn-intgrm reale --ws-intgrm github_2 --env-intgrm mpfw_fw2-main-app20240619_new_bis-5main git:status
                - ./repos_sync.sh --scn-intgrm reale --ws-intgrm github_2 --env-intgrm mpfw_fw2-main-app20240619_new_bis-5main git:log
        - modulo: mpfw_fw2-main-app20250424-5main
            - url: https://github.com/MuraDaco/mpfw_fw2-main-app20250424-5main
            - url repository pubblica IntgrM:       https://github.com/MuraDaco/mpfw_fw2-main-app20250424-5main.git
            - url repository pubblica Developer:    file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/mpfw_fw2-main-app20250424-5main.git
            - comando di syncro:
                - ./repos_sync.sh --scn-intgrm reale --ws-intgrm github_2 --publc "https://github.com/MuraDaco/mpfw_fw2-main-app20250424-5main.git" --dvlpr "file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/mpfw_fw2-main-app20250424-5main.git" --rel-name Update_First_Release --rel-inc 2
                    - N.B.: per eseguire questo comando non sono necessari i diritti di scrittura sulla repository remota di github
                - ./repos_sync.sh --scn-intgrm reale --ws-intgrm github_2 --env-intgrm mpfw_fw2-main-app20250424-5main git:status
                - ./repos_sync.sh --scn-intgrm reale --ws-intgrm github_2 --env-intgrm mpfw_fw2-main-app20250424-5main git:log
                    - N.B.: per verificare la corriposndenza dello sha1 dell'ultimo commit sulla repository dello sviluppatore controllare il branch remoto dvlpr1_local1/main associato al brnach locale dvlpr1_local1_main)
                    - il nickname "dvlpr1_local1" è proprio quello della repository pubblica dello sviuluppatore


- ./repos_sync.sh --scn-intgrm reale --ws-intgrm github --env-intgrm mpfw_code_apps_tst_20240203app git:status
--rel-name $release_name --rel-null $release_null  --rel-inc $release_inc"
- ./repos_list_sync.sh --public-intgrm <intgrm scenario> <intgrm scenario root directory> <intgrm root directory> <intgrm remote root directory, se scenario di test> --public-dvlpr <dvlpr scenario> <dvlpr scenario root directory, se scenario test> <dvlpr remote root directory, se scenario test> --create-local-public-repos --rel-name <release_name> --rel-null <release_null_list>  --rel-inc <release_inc_list> --range-down 3 --range-up 5
    - scenario reale totale
        - [<intgrm scenario>]       -> [reale] -> --publc "https://github.com/MuraDaco/<item>.git"
        - [<intgrm root directory>] -> /Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_<<intgrm scenario root directory>>/manager/intgrm_<intgrm root directory>
        - [<dvlpr scenario>]        -> [reale] -> --dvlpr "file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/<item>.git"
        - ./repos_sync.sh --scn-intgrm <<scenario root directory>> --ws-intgrm <root directory> 
            - --publc "https://github.com/MuraDaco/mpfw_code_apps_tst_20230703app.git"
            - --dvlpr "file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/mpfw_fw2-main-app20240619_new_bis-5main.git"
    - scenario reale parziale
        - [<intgrm scenario>]               -> [test] -> --publc "file:///Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_<intgrm scenario root directory>/remote/public/https/<intgrm remote root directory>/<item>.git"
        - [<intgrm root directory>]         -> /Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_<intgrm scenario root directory>/manager/intgrm_<intgrm root directory>
        - [<intgrm remote root directory>]  -> /Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_<intgrm scenario root directory>/remote/public/https/<intgrm remote root directory>
        - [<dvlpr scenario>]                -> [reale] -> --dvlpr "file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/<item>.git"
        - ./repos_sync.sh --scn-intgrm <scenario root directory> --ws-intgrm <root directory> 
            - --publc "https://github.com/MuraDaco/mpfw_code_apps_tst_20230703app.git"
            - --publc "file:///Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_reale/remote/public/https/github_3/mpfw_code_apps_tst_20230703app.git"
            - --dvlpr "file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/mpfw_fw2-main-app20240619_new_bis-5main.git"
    - scenario di test
        - [<intgrm root directory>]         -> $HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_<intgrm scenario root directory>/manager/intgrm_<intgrm root directory>
        - [<intgrm remote root directory>]  -> [$intgrm_remote_root_dir] = $HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_<intgrm scenario root directory>/remote/public/https/<intgrm remote root directory>
        - [<intgrm scenario>]               -> [test] -> --publc "file://[$intgrm_remote_root_dir]/<item>.git"
        - [<dvlpr remote root directory>]   -> [$dvlpr_remote_root_dir] = $HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_<dvlpr scenario remote root directory>/remote/developer/<dvlpr remote root directory>
        - [<dvlpr scenario>]                -> [test] -> --dvlpr "file://[$dvlpr_remote_root_dir]/<item>.git"
        - ./repos_sync.sh --scn-intgrm <intgrm scenario root directory> --ws-intgrm <intgrm root directory> 
            - --publc "file://$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_<intgrm scenario root directory>/remote/public/https/<intgrm remote root directory>/<item>.git"
            - --dvlpr "file://$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_<dvlpr scenario root directory>/remote/developer/<dvlpr remote root directory>/<item>.git"

---
 
Tue 26 May 2026 10:40:01 CEST

- creare da nuovo la repository dell'integration manager 
    - ovvero duplicare la directory "/Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_reale/manager/intgrm_github"

- comandi per la syncronizzazione della repository dell'integration manager
    - creare la repository in locale di un modulo già esistente nella repository pubblica su github
        - esempio
            - scenario reale parziale (repository remota su github viene simulata in locale, vedere il parametro dell'opzione --publc)
            - **$ ./repos_sync.sh --scn-intgrm reale --ws-intgrm test3 --publc "file:///Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_reale/remote/public/https/test_YYY/mpfw_code_apps_tst_20240203app.git" --dvlpr "file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/mpfw_code_apps_tst_20240203app.git" --rel-name First_Release --rel-null 1 3  --rel-inc 2**
                - con questo comando si crea automaticamante nel caso non ci fosse la repository dell'integration manager in locale
                    - /Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_[reale]/manager/intgrm_[test3]/mpfw_code_apps_tst_20240203app
                        - N.B.: le parole evidenziate ono quelle che dipendono dai parametri 
                            - "--scn-intgrm [reale]"
                            - "--ws-intgrm [test3]"
                - inoltre se l'URL della repository pubblica fa riferimento al protocollo "file://" anche la repository pubblica se non esiste viene creata, 
                - nel caso reale, in cui la repository remota è raggiungibile attraverso il protocollo "https://") questa deve essere creata "a mano" ovvero ci si deve collegare al server web e creare la repository
                - nel caso specifico del comando di esempio verrà creata la repository seguente nel caspo già non esistesse
                    - /Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_[reale]/remote/public/https/test_YYY/mpfw_code_apps_tst_20240203app.git
    - creare la repository in remoto ed in locale di un nuovo modulo
    - eseguire l'update di un modulo esistente
        - gestione dei numeri di release


- ./repos_sync.sh --scn-intgrm reale --ws-intgrm github --env-intgrm mpfw_code_apps_tst_20240203app git:status

./repos_list_sync.sh --public-intgrm <scenario> <root directory> --public-dvlpr <scenario> <root directory, se lo scenario e di test> --create-local-public-repos --range-down 3 --range-up 5

---

Mon 25 May 2026 09:23:34 CEST

- cose da fare
    - script [repos_sync.sh]
        - descrivere la corrispondenza dei parametri immessi nella linea di comando con i comandi eseguiti dallo script
    - script "repos_list_sync"
        - parametrizzare la directory di test per il caso reale-parziale
            - al momento è impostata in modo fisso su "test1"/"test3"
        - implementare i comandi
            - il tag delle versioni
                - questo comando dovrebbe escludere le repository vecchie 
            - push sulla directory pubblica
        - in questo modo si evita di avere più script di list

- come utilizzare & come lavora lo script [repos_sync.sh]
    - lo script [repos_sync.sh] implementa lo schema dell'**integration manager** ed in particolare
        - esegue le procedure di sincronizzazione tra quanto viene pubblicato nella repository presente su [github] e la repository di sviluppo
            - N.B.: al momento la procedura ed i relativi esempi considerano un solo sviluppatore; per gestire più sviluppatori certamente qualcosa dovra essere aggiornato
            - il riferimento è la repository dello sviluppatore nel senso che la repository locale dell'**integration manager** deve avere una copia speculare nel suo branch [github_main] del branch [main] della repository  pubblica dello sviluppatore
            - a questo scopo la [intgrm_repo] ha due branch indipendenti (nessun commit in comune):
                - [github_main] (associato al brnach main della repo pubblica di github) e 
                - [dvlpr_main] (associato al branch main della repository pubblica dello sviluppatore raggiungibile nel caso specifico al path [/Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs])
                - N.B.: il trasferimento/syncronizzazione del contenuto del branch [dvlpr_main] sul branch [github_main] avviene attraverso il comando di merge con le opzione di 
                    - --squash: elimina lo storico dei commit
                    - --allow-unrelated-histories: permette il merge tra due branch tra loro indipendenti
                    - <git squash>
                    - il comando di <git squash> permette di eliminare lo storico dei commit sul branch [github_main]
        - esegue il push dal branch [github_main] al branch [main] della rspository pubblica su [github]
            - [--env-intgrm]
                - l'opzione [--env-intgrm] indica il fatto che lo script "entrerà" (eseguira il comando "cd") nella reposiotry del modulo ed eseguirà i comandi indicati nei suoi parametri
                    - in particolare gli unici diponibili
                        - [git:push]
                        - [git:log]
                - esempio:
                    - <repos_sync.sh --scn-intgrm reale --ws-intgrm test3 --env-intgrm "mpfw_code_apps_tst_20240203app" git:push>
                - questa opzione ha lo scopo di permettere di 
                    - eseguire il push in modo separato dalla procedura di syncronizzazione fatta in locale
                    - eseguire il log della repositorty dell'integration manager per controllare che tutto sia a posto
        - permette di gestire uno scenario di test 
            - simulando 
                - 1) le repository locale e/o pubblica
                - e 2) le attività, riguardanti il codice, di modifica e update
                - degli sviluppatori
                - per questo scopo si esegue lo script [repos_sync.sh] con le seguenti opzioni ed opportuni relativi parametri
                    - [--env-dvlpr]
                    - [--env-dvlpr-remote]
                    - in particolare a questi parametri sono associati comandi <git>
                        - [git_add]
                        - [git_remote]
                        - [git_log]
                        - [git_commit]
                        - [git_fetch]
                        - [remote_push]
                        - [new_files]
                        - [upd_files]
- come utilizzare & come lavora lo script [repos_list_sync.sh]
    - esegue la sincronizzazione di una lista di repository
        - naturalmente chiamerà lo script [repos_sync.sh]


- dubbi e domande
    - come viene verificata l'uguaglianza/diversità tra il branch main dello sviluppatore e quello dell'integratioon manager?
        - viene eseguito il comando di <git diff> tra i due branch [github_main] e [dvlpr(xxx)_main] nella repository dell'integration manager
    - per verificare la sincronizzazione tra la repository locale e quella remota pubblica dell'integration manager si confrontano i rispettivi ultimi commit, 
        - in particolare i commit del branch [github_main] dellla repo locale e del branch [main] della repo pubblica
    - come creare due branch indipendenti all'interno di una repository (si rammenta che questa è la repository dell'integration manager)
        - viene prima creato il branch associato alla repository su github con il comando
            - git checkout -b <nome branch>
        - poi viene creato il branch associato alla repository pubblica dello sviluppatore con i comandi
            - git fetch <nick name repository pubblica sviluppatore> main:<nome del branch associato allo sviluppatore> && {
            - git branch --set-upstream-to=<nick name repository pubblica sviluppatore>/main <nome del branch associato allo sviluppatore> }



..... estratto da [note_20251003_integration_manager.md]

Last login: Fri Oct  3 06:46:51 on console
update: Fri 22 May 2026 07:07:43 CEST

- gestione del numero di revisione
    - [<sha1 of last commit>] <nome della release> release ver. <rel 1>.<rel 2>.<rel 3>.[<sha1 dell ultimo commmit del branch dello sviluppatore>]
        - esempio
            - $ git show-branch --sha1-name github_main
            - [b6c281b] First_Release release ver. 0.2.0.[c2c5e96]

- descrizione scenarii
    - descrizione
        - gli scenarii di test sono caratterizzati/determinati dalla locazione delle reposiotries coinvolte nello schema dell'**integration manager**, quindi
            - [repo_dvlpr] repository di lavoro dello sviluppatore
                - ne possono esistere più di una almeno quanti sono gli sviluppatori
                    - N.B.: gli sviuluppatori possono decidere di averne anche più di una
            - [repo_intgrm] repository di lavoro dell'integration manager
                - ne esiste solo una
            - [repo_dvlpr_remote] repository pubblica dello sviluppatore
                - ne possono esistere più di una
            - [repo_uffcl_remote] repository pubblica UFFICIALE del progetto/modulo, nel caso reale totale è quella che si trova su "github.com"
                - ne esiste solo una
    - gestione [repo_uffcl_remote] negli scenarii reali, parziale e totale
        - scenario
            - reale parziale
                - modulo non esiste
                    - l'**integration manager** deve 
                        - step 1
                            - creare la repository pubblica ufficiale eseguendo lo script [repos_sync.sh] con i seguenti parametri
                                - [--scn-intgrm]       --> <**$scenario_intgrm**>
                                - [--env-publc-remote] 
                                    - --> [$env_publc_remote](1)(primo parametro della lista)   -> <**root_folder_path_dvlpr**>
                                    - --> [$env_publc_remote](2)(secondo parametro della lista) -> <**project_name**>
                                    - /**$HOME**/ObsiData/distributed_git/integration_manager_workflow/scenario_<scenario_intgrm>/remote/public/https/<**root_folder_path_dvlpr**>/<**project_name**>
                                - esempio
                                    - **./scrp/intgrm/scrp/repos_sync.sh --scn-intgrm reale --env-publc-remote [test_XXX] mpfw_code_apps_tst_20240203app**
                                        - /**$HOME**/ObsiData/distributed_git/integration_manager_workflow/scenario_reale/remote/public/https/github/mpfw_code_apps_tst_20240203app.git
                                        - N.B.: creare preventivamente la directory /**$HOME**/ObsiData/distributed_git/integration_manager_workflow/scenario_reale/remote/public/https/[test_XXX]
                        - step 2
                            - creare nella sua workstation la repository del modulo 
                                - oppure eseguire il clone della repository vuota creata al punto precedente
                        - step 3
                            - eseguire la procedura di syncronizzazione eseguendo lo script [repos_sync.sh]
                                - questa procedura farà quanto segue
                                    - crea i due branch tra loro indipendenti ovvero senza nessun commit in comune
                                        - quello associato alla repository pubblica creata allo step 1
                                        - quello associato alla reposiotry pubblica dello sviluppatore
                                    - esegue la syncronizzazione tra i due branch
                                        - in particolare "copia" il branch dello sviluppatore nel branch ufficiale
                                            - N.B.: questa "copia" sarà eseguita per mezzo del comando <git squash>
                        - step 4
                            - eseguire il push dalla repository locale dell'inytegration manager a quella pubblica creata allo step 1
            - reale totale
                - modulo non esiste
                    - l'**integration manager** deve 
                        - step 1
                            - collegarsi all'account github e creare una reposiotry vuota con il nome del modulo
                        - step 2
                            - creare nella sua workstation la repository del modulo 
                                - oppure eseguire il clone della repository vuota creata al punto precedente
                        - step 3
                            - eseguire la procedura di syncronizzazione eseguendo lo script [repos_sync.sh]
                                - questa procedura farà quanto segue
                                    - crea i due branch tra loro indipendenti ovvero senza nessun commit in comune
                                        - quello associato alla repository pubblica creata allo step 1
                                        - quello associato alla reposiotry pubblica dello sviluppatore
                                    - esegue la syncronizzazione tra i due branch
                                        - in particolare "copia" il branch dello sviluppatore nel branch ufficiale
                                            - N.B.: questa "copia" sarà eseguita per mezzo del comando <git squash>
                        - step 4
                            - eseguire il push dalla repository locale dell'inytegration manager a quella pubblica creata allo step 1
                - modulo esiste
                    - l'**integration manager** esegue il clone della repository del modulo sulla sua workstation
                        - /**$HOME**/ObsiData/distributed_git/integration_manager_workflow/scenario_<nome scenario>/manager/intgrm_<nome workstation>
    - scenario di test
        - N.B.: in questo scenario sono simulate sia le repositories degli sviluppatori sia la reposiotry pubblica ufficiale
        - [repo_dvlpr]
            - path
                - /**$HOME**/ObsiData/distributed_git/integration_manager_workflow/scenario_1/developers/<nome workstation>
            - parametri
                - [--env-dvlpr](primo parametro della lista) --> <nome workstation>
        - [repo_intgrm]
            - path
                - /**$HOME**/ObsiData/distributed_git/integration_manager_workflow/scenario_<nome scenario>/manager/intgrm_<nome workstation>
            - parametri
                - [--scn-intgrm]    --> <nome scenario>
                - [--ws-intgrm]     --> <nome workstation>
                - [--env-intgrm]    --> <nome modulo> e <comandi git da eseguire sulla repository>
        - [repo_dvlpr_remote]
            - path
                - /**$HOME**/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/developer/<**1st parameter of --env-dvlpr-remote option**>
            - parametri per impostare la repo
                - [--env-dvlpr-remote](primo parametro della lista) --> [$env_dvlpr_remote]
        - [repo_uffcl_remote]
            - path
                - /**$HOME**/ObsiData/distributed_git/integration_manager_workflow/scenario_<nome scenario>/remote/public/https/<**1st parameter of --env-publc-remote option**>
            - parametri per impostare la repo
                - [--scn-intgrm]                                    --> <nome scenario>
                - [--env-publc-remote](primo parametro della lista) --> [$env_publc_remote]
    - scenario reale parziale 
        - N.B.: in questo scenario sono vere solo le reposiotries degli sviluppatori 
            - mentre la repository pubblica ufficiale viene simulata in locale
        - [repo_dvlpr]
            - N.B.: non gestite, vedere caso reale totale
        - [repo_intgrm]
            - path
                - /**$HOME**/ObsiData/distributed_git/integration_manager_workflow/scenario_<nome scenario>/manager/intgrm_<nome workstation>
            - parametri
                - [--scn-intgrm]    --> <nome scenario>
                - [--ws-intgrm]     --> <nome workstation>
                - [--env-intgrm]    --> <nome modulo> e <comandi git da eseguire sulla repository>
            - example
                - ./scrp/intgrm/scrp/repos_sync.sh --scn-intgrm reale --ws-intgrm test2 --publc "file:///Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_reale/remote/public/https/github/mpfw_code_apps_tst_20240203app.git" --dvlpr "file:///Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_reale/remote/public/https/github/mpfw_code_apps_tst_20240203app.git" --rel-name First_Release --rel-null 1 3  --rel-inc 2
                - ./scrp/intgrm/scrp/repos_sync.sh --scn-intgrm reale --ws-intgrm test2 --env-intgrm "mpfw_code_apps_tst_20240203app" git:log
        - [repo_dvlpr_remote]
            - N.B.: non gestite, vedere caso reale totale
        - [repo_uffcl_remote]
            - N.B.: la repository remota pubblica ufficiale, quella che si trova su github.com, viene simulata in locale
                - quindi questa repository la si può vedere anche come il backup di quella reale presente su github.com
                - per creare le repository dei moduli ci sono due possibilità
                    - eseguire lo script [repos_list_sync.sh]
                        - N.B.: questo script crea le reposiotries dei moduli vuote e poi con lo script [repos_list_push.sh] vengono riempite con il comando di push
                        - con i parametri
                            - [--create-local-public-repos]
                    - eseguire lo script [repos_sync.sh]
                        - con i parametri
                            - [--scn-intgrm]                                    --> <nome scenario>
                            - [--env-publc-remote](primo parametro della lista) --> [$env_publc_remote]
            - path
                - /**$HOME**/ObsiData/distributed_git/integration_manager_workflow/scenario_<nome scenario>/remote/public/https/[root_folder_path_dvlpr]/[project_name]
                - parametro dell'opzione [--publc]
            - parametri per impostare la repo
                - [--scn-intgrm]                                        --> <nome scenario>
                - [--env-publc-remote](primo parametro della lista)     --> [$env_publc_remote]     --> [root_folder_path_dvlpr]:  nome root folder delle reposiotries>
                - [--env-publc-remote](secondo parametro della lista)   --> [$env_publc_remote]     --> [project_name]
            - example
                - $ ./scrp/intgrm/scrp/repos_sync.sh --scn-intgrm reale --env-publc-remote test_XXX mpfw_code_apps_tst_20240203app 
                    - N.B.: la folder "test_XXX" deve esistere lo script non la crea quindi se non è stata creata si otterrà un errore
                        - <ERROR - root folder of remote repos DOES NOT exist - l_root_remote_repos_folder: /Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_reale/remote/public/https/test_XXX>
    - scenario reale (totale)
        - [repo_dvlpr]
            - non esiste
            - N.B.: in questo scenario le repositories di lavoro degli sviluppatori non vengono gestite dal momento che sono quelle vere, e queste sono gestite solo dagli sviluppatori
                - quindi non sono presenti nella directory "/**$HOME**/ObsiData/distributed_git/integration_manager_workflow"
        - [repo_intgrm]
            - path
                - /**$HOME**/ObsiData/distributed_git/integration_manager_workflow/scenario_<nome scenario>/manager/intgrm_<nome workstation>
            - parametri
                - [--scn-intgrm]    --> <nome scenario>
                - [--ws-intgrm]     --> <nome workstation>
                - [--env-intgrm]    --> <nome modulo> e <comandi git da eseguire sulla repository>
        - [repo_dvlpr_remote]
            - non esiste
            - N.B.: sono quelle vere, nel caso specifico di colui che scrive la presente nota si trovano in un harddisk esterno raggiungibile via interfaccia di rete ethernet con il protocollo samba
                - in generale sono presenti in un server pubblico accessibile attarverso l'interfaccia di rete con protocollo https
                - quindi non sono presenti nella directory ""/**$HOME**/ObsiData/distributed_git/integration_manager_workflow""
        - [repo_uffcl_remote]
            - la repository remota pubblica **ufficiale** è proprio quella che si trova su github.com
            - quindi non è presente nella directory ""/**$HOME**/ObsiData/distributed_git/integration_manager_workflow""
    
- procedura "standard"/"principale" & opzioni di servizio 
    - la procedura "standard"
    - le opzioni di servizio sono
        - --reset (min. priority)   
        - --test-var                
        - --env-intgrm
            - permette di eseguire dei comandi git sulla repository di lavoro dell'integration manager
                - lo script **repos_sync.sh** può essere eseguito in qualunque directory
                - la directory che interessa nel caso reale è quella dell'integration manager e si trova al seguente path
                    - /$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_reale/manager/intgrm_github
                - in particolare questi comandi permettono di 
                    - conoscerene lo stato
                    - ed eseguire il push sulla repository remota pubblica **ufficiale**
        - --env-dvlpr
        - --env-dvlpr-remote        
        - --env-publc-remote        
            - queste tre opzioni permettono di gestire l'ambiente di test
            - in particolare permettono di gestire attraverso comandi git le repository degli sviluppatori 
                - N.B.: queste repositories simulano quelle degli sviluppatori reali, nello scenario reale non vengono considerate
                - le repository su cui lavorano gli sviluppatori sono tre
                    - di lavoro(associata all'opzione [--env-dvlpr])
                        - dove lavora lo **sviluppatore**
                        - questa repository deve avere il branch "main", questo è il branch a cui fa riferimento l'**integration manager** per eseguire gli update 
                    - pubblica (dello sviluppatore, non ufficiale, associata all'opzione [--env-dvlpr-remote])
                        - dove lo **sviluppatore** pubblica le sue release
                        - e dalla quale l'**integration manager** esegue il download degli update implementati dagli sviluppatori
                            - l'**integration manager** ha solo i diritti di lettura su questa repository
                    - pubblica "ufficiale" (associata all'opzione [---env-publc-remote])
                        - dove
                            - lo **sviluppatore** esegue il download delle release su cui lavorerà
                                - N.B.: può succedere che i moduli siano sviluppati da più persone e quindi la release su cui sta lavorando uno sviluppatore può non essere l'ultima
                                - lo **sviluppatore** ha solo dirtti di lettura su questa repository
                            - l'**integration manager** pubblica le release uffciali del progetto
                                - l'**integration manager** è l'unico ad avere i diritti di scrittura e quindi l'unico che può eseguire i "push" delle release
                                    - attraverso l'opzione "--env-intgrm" (N.B.: questa opzione è attiva anche nello scenario reale e non solo di test) l'integration manager può
                                        - controllarne lo stato (eseguire il comando "git status")
                                            - solo nel caso di scenario di test/backup in cui le repository pubblica ufficiale è simulata da una repostiroy che risiede in locale
                                        - eseguire il comando di push per pubblicare le release ufficiali (git push)
        - --help (max. priority)    


- list syncro
    - ls "/Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs" 2>/dev/null | grep "mpfw_code"

    - ./repos_list_sync.sh --public-intgrm local --public-dvlpr real --create-local-public-repos --range-down 3 --range-up 5
    - ./repos_list_push.sh --public-intgrm local --range-down 0 --range-up 2  
    - ./repos_sync.sh --scn-intgrm reale --ws-intgrm test3 --env-intgrm "mpfw_code_apps_tst_20240203app" git:log 
    - cat repo_lists_log_3_5.txt



..... fine estratto [note_20251003_integration_manager.md]

---

Fri 22 May 2026 07:07:43 CEST



---

Wed 13 May 2026 07:59:14 CEST

- come creare da zero l'ambiente di lavoro per l'**integration manager**

- analisi del codice dello script
    - scopo
        - capire come creare una nuova repository nell'ambiente di lavoro (in pratica nella directory) dell'**integration managere**
            - gestione delle opzioni
                - opzioni associate a procedure diverse da quella standard
                    - le seguenti opzioni eseguono una serie di operazioni diverse dalla procedura standard di sincronizzazione
                    - inoltre il loro ordine fornisce la priorità con cui vengono scelte ed eseguite nel caso siano presenti contemporaneamente più opzioni
                    - quindi la priorità più bassa la ha l'opzione "--reset" quella più alta la ha l'opzione "--help"
                        - --reset (min. priority)   -->     [ -n "$repo_to_reset" ]   
                        - --test-var                -->     [ -n "$g_test_var" ]      
                        - --env-intgrm              -->     [ -n "$env_intgrm" ]      
                        - --env-dvlpr               -->     [ -n "$env_dvlpr" ]       
                        - --env-dvlpr-remote        -->     [ -n "$env_dvlpr_remote" ]
                        - --env-publc-remote        -->     [ -n "$env_publc_remote" ]
                        - --help (max. priority)    -->     [ -n "$g_help" ]     
                - opzioni associate alla procedura standard ma anche ad alcune di quelle precedenti
                    - --scn-intgrm
                    - --ws-intgrm
                    - --dvlpr
                    - --publc
                    - --rel-name
                    - --rel-inc
                    - --rel-null
    - descrizione della procedura standard
        - la procedura standard è quella che gestisce la repository dell'**integration managere** dei vari moduli
        - in particolare
            - crea la repository del modulo
            - crea i due branch indipendenti nella repository del modulo sincronizza


---

Tue 12 May 2026 10:25:41 CEST

- descrizione delle opzioni e dei parametri utilizzati nello script "./scrp/repos_sync.sh"
    - opzione 
        - --env-intgrm
        - --env-dvlpr
        - --scn-intgrm
        - --ws-intgrm
            - attivo solo per l'ambiente di test (?? non mi risulta !!!)
    - descrizione delle combinazioni
        - --scn-intgrm reale --ws-intgrm github
            - combinazione di opzioni e parametri usati nel caso reale
        - --scn-intgrm reale --ws-intgrm test1
            - combinazione di opzioni e parametri usati nella simulazione del caso reale (che si può vedere come backup/copia delle repository presenti su github.com) ovvero con i moduli veri ma con la repository remota in locale e non su "github.com"

- procedura per sincronizzare la repository  remota su github
    - step 0
        - collegare/abilitare l'unita HD esterna dove risiedono le repository remote "pubbliche" dei moduli
            - mac OSx
                - Finder
                    - barra in alto, barra del menu
                        - selezionare la voce "Go"
                            - nel sotto menu
                                - selezionare la voce "Connect to Server ..."
                                    - nella finestra inserire
                                        - "smb://192.168.56.2/mypass2" nel caso l'hd sia collegato alla workstation e quindi il server samba risiede nella macchina virtuale
                                        - "smb://192.168.8.1/mypass2" nel caso l'hd sia collegato al router esterno "gliNet"
                                    - dopo questa operazione la directory "mypass2" dell'hd esterno è montato sul file system del macOSx e lo si raggiunge usando il seguente path
                                        - "/Volumes/mypass2"
    - step 1
        - aggiornare i branch "main" di tutti i moduli
            - N.B.: 
                - l'**integration manager** legge solo i branch "main" dei moduli da pubblicare
                - l'**integration manager** legge i moduli presenti nella repository remota pubblica dello sviluppatore
                    - questa directory è presente nell'harddisk esterno che viene identificato con il nome "mypass2"
                        - questo harddisk è formattato con il file system linux "ext4" ed è accessibile dalla workstation via interfaccia di rete per mezzo di un client samba
                            - il server samba può risiedere 
                                - in un dispositivo fisico esterno alla workstation dell'**integration manager**
                                - in una macchina virtuale interna alla workstation dell'**integration manager**
                        - se l'integration manager lavora con una workstation con sistema operativo 
                            - mac OSx
                                - dovra attivare il client samba e collegarsi all'harddisk attraverso il protocollo samba 
                                    - "smb://192.168.56.2/mypass2" (nel caso di server presente sulla macchina virtuale)
                                    - "smb://192.168.8.1/mypass2" (nel caso di server presente sul router)
                                - dopo attivato il collegamento con il server samba può accedere alla repository con il seguente path "/Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs"
            - le sequenze di comandi da dare usando lo script "obDash" sono
                - per vedere lo stato della syncronizzazione
                    - scelta del menu
                        - (4) menu:Branch: Create, Checkout, ... branch
                    - scelta del comando da eseguire
                        - (2) command:BYC: Branch Synchro status check
                    - scelta del gruppo di moduli su cui applicare il comando
                        - (4) project
                    - scelta del modulo su cui eseguire il comando
                        - (5) repo__main/smdl/repo__prjs/smdl/mpfw : code/mpfw_code
                    - scelta della modalità 
                        - (2) Recursive:   perform the commands recursively
    - step 2

    - procedura pr creare una ambiente di test del caso reale quindi con moduli "veri" e non fittizi
        - in pratica duplicare la directory test1 ("/Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_reale/manager/intgrm_test1")
            - questa directory simula la directory remota su github dove risiedono tutte le repository dei moduli
        - steps
            - step 1 - 
            - step 2



---

./scrp/repos_sync_new.sh --publc "file:///Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/public/https/github/Module_02.git" --dvlpr "file:///Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/developer/mypass2_repo/Module_02.git" --ws-intgrm ws6

---

- analisi del singolo comando di sincronizzazione
    -     ./scrp/intgrm/scrp/repos_sync.sh --scn-intgrm reale --ws-intgrm test1 --publc "file:///Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_reale/remote/public/https/github/mpfw_code_apps_tst_20221206.git" --dvlpr "file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/mpfw_code_apps_tst_20221206.git" --rel-name First_Release --rel-null 1 3  --rel-inc 2
        - --scn-intgrm reale
            - indica la directory "/Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_**reale**"
        - --ws-intgrm test1
            - indica la directory "/Users/work/ObsiData/distributed_git/integration_manager_workflow/scenario_**reale**/manager/intgrm_**test1**"
        - --publc
            - si imposta l'url della reposityory publica, in questo caso viene simulata la repository "github"
        - --dvlpr
            - si imposta l'url della reposityory privata di lavoro dell'integration manager
            - in questa repository sono presenti due branch tra loro indipendenti nel senso che
                - hanno un origine diversa, ovvero non hanno nessun commit in comune
                - puntano a reposiotry remote diverse
                    - uno ("github_main") punta alla repository presente su github.com (o nel caso di test ad una repository locale che simula la repository su github.com)
                    - l'altro ("dvlpr1_local1_main") punta alla repositoryu pubblica dello sviluppatore "dvlpr1"
            - in questa repository viene eseguita la sincronizzazione dei due branch di cui sopra
                - al momento il branch dello sviluppatore non viene m,odificato ovvero viene eseguito solo il comando di pull rispetto la repository remota ad esso associato
                - quindi solo il branch associato alla repository remota su github.com ("github_main") viene aggiornato aggiungendo le varie release 
                    - "ripulite" dallo storico dei commit dello sviluppatore
                - ad ogni release,quindi ad ogni commit del branch "github_main", è presente il riferimento al commit del branch
                - i numeri delle release sono impostyati in funzione dei parametri "--rel-null"  "--rel-inc"
        - --rel-name
        - --rel-null
            - questa opzioone richiede una lista di parametri in particolare l'ordine dei numeri di release, 
                - i numeri di release corrispondenti a quegli ordine saranno iompostati a zero
                - ad esempio --rel-null 1 3 darà come risultato di releaase 0.<old>.0
        - --rel-inc
            - questa opzioone richiede una lista di parametri in particolare l'ordine dei numeri di release, 
                - i numeri di release corrispondenti a quegli ordine saranno iompostati a zero
                - ad esempio --rel-null 1 3 darà come risultato di releaase <old>.<old>+1.<old>
    - ./scrp/intgrm/scrp/repos_sync.sh --scn-intgrm reale --ws-intgrm test1 --env-intgrm "mpfw_code_apps_tst_20221206" git:log



---

- gestione della reoposiotry **github**
    - schema usato
        - **integration manager**
            - aspetti da considerare
                - gestione della ripository di un singolo modulo
                    - scenario
                        - di test
                            - simulazione della repository github
                                - i moduli che vengono gestiti sono quelli reali
                                - la repository remota pubblica, github, viene simulata in locale
                            - test con moduli di prova
                                - i moduli sono creati al momento e contengono solo pochi file di test necessari per le prove
                        - reale
                    - problematiche
                        - creare la repository **integration manager**
                            - da nuovo
                                - case 1: la repo remota github già esiste
                                - case 2: la repo remota github non esiste
                            - aggiungere nuovi moduli creati dagli sviluppatori
                        - aggiornare i moduli presenti
                        - gestione delle revisioni
                        - pulizia dello storico dei commit nella repository publica github
                        - gestioone di due branch indipendenti all'interno di una stessa repository (la repository dell'integration manager)
                - gestione della lista di moduli

