
---

Mon  8 Jun 2026 10:16:54 CEST

- eseguire il report del db di "n" giorni in dietro
    - $ time_start=$(cat test_read.txt | grep "activity_start_event" | tail [-$1] | cut -d':' -f 3)
    - $ time_last=$(cat test_read.txt | grep "activity_periodic_recording_event" | tail -1 | cut -d':' -f 3)

day_back=2; cat test_read.txt | grep -n "activity_start_event" | tail -$day_back | head -1 | cut -d':' -f 1
day_back=2; ((day_back_next = $day_back - 1));cat test_read.txt | grep -n "activity_start_event" | tail -$day_back_next | head -1 | cut -d':' -f 1
((day_back = $1 + 1 ))
((day_back_next = day_back - 1 ))
line_day_start=$(       cat test_read.txt | grep -n "activity_start_event" | tail -$day_back      | head -1 | cut -d':' -f 1)
line_next_day_start=$(  cat test_read.txt | grep -n "activity_start_event" | tail -$day_back_next | head -1 | cut -d':' -f 1)

work@umtiefs-Mac-mini time % line_day_back=4; line_next_day_back=110; sed -n "$line_day_back, $line_next_day_back p" test_read.txt
work@umtiefs-Mac-mini time % line_day_back=4; line_next_day_back=110; ((line_delta = $line_next_day_back - $line_day_back + 1 )); cat test_read.txt | head -$line_next_day_back | tail -$line_delta

line_day_start=$(       cat test_read.txt | grep -n "activity_start_event" | tail -$day_back      | head -1 | cut -d':' -f 1)
line_next_day_start=$(  cat test_read.txt | grep -n "activity_start_event" | tail -$day_back_next | head -1 | cut -d':' -f 1)
((line_delta = $line_next_day_back - $line_day_back + 1 ))

sed -n "$line_day_back, $line_next_day_back p" test_read.txt
cat test_read.txt | head -$line_next_day_back | tail -$line_delta

if(line_day_start == line_next_day_start) non ci sono report per il giorno richiesto, l'ultimo giorno disponibile è ....
time sed -n '4, 110p' test_read.txt 
time ( cat test_read.txt | head -110 | tail -107 )



---

Fri  5 Jun 2026 09:07:59 CEST

- command
    - [report_sum]
        - totale del tempo di idle
        - totale del tempo di attività = (orario corrente - orario start attivita) - totale tempo di idle
    - [report_details]
        - init
            - [time_array_start_event_sec] = ore 04.00 del giorno delezionato
            - <id array last> = 18 ore / 5 min = 216
            - <id array> = 0
        - loop (<row db> of [activity_periodic_recording_event])
            - <id array current> = <id array>
            - loop (<id array current> up to <id array last>)
                - [time_periodic_array_event]<id array> = [time_array_start_event_sec] + <id array>*[PERIOD_recording]
                - [time_periodic_rec_event]<row db> >= [time_periodic_array_event]<id array> && [time_periodic_rec_event]<row db> < [time_periodic_array_event]<id array + 1>
                    - [activity_level]<id array> = [activity_level]<row db>
                    - inc <id array>
                    - break (exit from loop (<id array> ))
                - [otherwise]
                    - [activity_level]<id array> = 0
                    - inc <id array>
            - next <row db>
        - loop (<id array current> up to <id array last>)
            - [activity_level]<id array> = 0
            - inc <id array>
        - oppure
        - loop (<id array>)

1780650600 / 1780657616
1780650900 / 1780657616
1780651200 / 1780657616
1780651500 / 1780657616
1780651800 / 1780657616
1780652100 / 1780657616
1780652400 / 1780657616
1780652700 / 1780657616
1780653000 / 1780657616
1780653300 / 1780657616
1780653600 / 1780657616
1780653900 / 1780657616
1780654200 / 1780657616
1780654500 / 1780657616
1780654800 / 1780657616
1780655100 / 1780657616
1780655400 / 1780657616
1780655700 / 1780657616
1780656000 / 1780657616
1780656300 / 1780657616
1780656600 / 1780657616
1780656900 / 1780657616
1780657200 / 1780657616
1780657500 / 1780657616


---

Thu  4 Jun 2026 07:04:46 CEST



---

Wed  3 Jun 2026 07:53:53 CEST

- implementazione dello script [timeReg.sh]
    - interazione con l'utente
        - usare un file in cui le righe rappresentano dei comandi
    - eventi
        - registrazione ogni 5 minuti
        - registrazione dell'evento di idle
            - quando si verifica un evento di attività e il valore del [time_idle] nel precedente controllo era maggiore di 5minuti
    - struttura del DB ovvero i campi del record
        - esempio
            - 142536364;[activity_event_start]
            - 142536664;[activity_level_event] <livello attività = numero di [reset_idle] nel periodo> (è un evento periodico che si ripete ad intervalli regolari quando il [time_idle] è inferiore a 5minuti valore di default dell'intervallo: 5minuti)
            - 142536964;[activity_level_event] <livello attività = numero di [reset_idle] nel periodo> (è un evento periodico che si ripete ad intervalli regolari quando il [time_idle] è inferiore a 5minuti valore di default dell'intervallo: 5minuti)
            - 142537624;[activity_level_event] <livello attività = numero di [reset_idle] nel periodo> (è un evento periodico che si ripete ad intervalli regolari quando il [time_idle] è inferiore a 5minuti valore di default dell'intervallo: 5minuti)
            - // 142537197;[activity_level_last_event] <livello attività = numero di [reset_idle] nel periodo> (è un evento associato alla regitrazione del periodo di idle, il suo orario deve essere tale che ) 
            - // 142538765(fine dell'[activity_period] = ultimo [activity_event] = inizio dell'[idle]); numero [activity_event]
            - // 142538765;[idle] (maggiore o uguale a 5 miniuti) (l'[idle] è l'intervallo di tempo tra due [activity_event] l'ultimo ed il primo di due serie di [activity_event])
            - 142538765;(fine [period_idle]) [activity_start_event];142536964 (è l'orario dell'ultimo evento di attività [time_activity_last_event] prima che si verificasse l'evento corrente, corrisponde all'inizio del periodo di idle)
        - N.B.:
            - il controllo degli eventi di [reset_idle] avviene ogni secondo
                - N.B.: 
                    - il [time_idle] viene fornito dal sistema in particolare è una voce/item del registro [IOHIDSystem]
                    - la registrazione del periodo di idle avviene con il codice [period_idle]
                - se [time_idle]
                    - è > 0 (NON è stata rilevata nessuna attività) 
                        - si incrementa il contatore [cntr_time_idle]
                            - N.B.: se si decide di calcolare il tempo di idle [time_intervall_idle] questa azione  non serve più eseguirla
                    - è = 0 (è stata rilevata attività) 
                        - [memorizzare] l'orario corrente [time_current]
                        - [calcolare] il tempo di idle [time_intervall_idle] = [time_current] - [time_activity_last_event]
                        - [controllare] il contatore [time_intervall_idle] or [cntr_time_idle]
                            - se [cntr_time_idle] or [time_intervall_idle]
                                N.B.: usare [time_intervall_idle] invece del contatore di idle [cntr_time_idle] dovrebbe risolvere il problema di quando il sistema va in sleep
                                - è > 5min
                                    - [registrare] il periodo di idle [period_idle]
                                        - i dati o le informazioni necessari per registrare il periodo di idle [period_idle] sono
                                            - orario corrente
                                            - [time_activity_level_event] oppure [cntr_time_idle]
                                                - N.B.: 
                                                    - [time_activity_last_event] è l'orario dell'ultimo evento di attività [activity_last_event] che corrisponde anche all'inizio del periodo di idle
                                                    - l'orario di inzio del periodo di idle [time_activity_last_event] certamente si troverà compreso tra gli ultimi due eventi periodici [activity_level_event]
                                                    - inoltre il periodo di idle è dato da [time_current] - [time_activity_last_event] = [cntr_time_idle]
                                                        - quindi memorizzare [time_activity_last_event] non sarebbe necessario
                                            - // [cntr_activity_level] 
                                                N.B.: forse questo non è necessario perchè è già stato registrato nell'ultimo evento periodico [activity_level_event]
                                    - // [resettare] il contatore del livello di attività [cntr_activity_level] (porlo = 0)
                                        - N.B.: probabilmente non c'è b isogno di eseguire questo reset dal momento che è giaà stato effettuto in corrispondenza dell'ultimo evento periodico [activity_level_event]
                                - è < 5min
                                    - [incrmentare] il contatore del livello di attività [cntr_activity_level]
                        - [resetttare] il  contatore [cntr_time_idle] (porlo = 0)
                        - [aggiornare] l'orario dell'ultimo evento di attività [time_activity_last_event] (porlo = [time_current])
                            - [memorizzare] l'orario corrente come orario dell'ultimo evento di attività [time_activity_last_event]
                                - N.B.: come fatto notare precedentemente memorizzare questo parametro non sarebbe strettamente necessario
            - periodicamante vengono registrati i livelli di attività [cntr_activity_level] con codice [activity_level_event]
                - N.B.: 
                    - il periodo di default è 5 minuti
                    - non viene eseguita nessuna registrazione se il contatore degli eventi di attività è nullo ovvero ci si trova in uno stato di idle
                - i livelli di attività vengono registrati con il codice di [activity_level_event]
                - sono eseguite le seguenti azioni
                    - [registrazione] del contatore del livello di attività [cntr_activity_level] con codice [activity_level_event] 
                    - [reset] del contatore del livello di attività [cntr_activity_level] (porlo = 0)
    - registrazione dei dati
        - registrare significa aggiungere una stringa, rappresentante un record, ad un array di stinghe
        - prima di eseguire lo shutdown del sistema di dovrebbe trasferire il contenuto di questo array in un file
            - lo si può fare manualmente con un comando
            - o automatomaticamente, per far questo bisogna
                - intercettare il segnale di kill rivolto a se stesso ed eseguire un'azione, ad esempio trasferire in un file un array di stringhe, prima di essere eliminato
                - ovvero eseguire un'azione prima di essere chiuso in modo forzato ad un'altra applicazione
                    - in questo modo anche se ci si dimentica di dare il comando di registrazione comunque verrà eseguito prima della chiusura del sistema
                - intercettare il segnale di shutdown del sistema
        


04          05            06            07            08            09            10            11            12           13
0     1/2   1     1/2     2     1/2     3     1/2     4     1/2     5     1/2     6     1/2     7     1/2     8     1/2     9
|-_-_-|-_-_-|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|
   |: :::: :.::.   ::::..:::  ..::  :: :::: :'°~:.   ::::..:::  ..::  :: :::: :.::.   ::::..:::  ..::  :: :::: :.::.  ::::..:::
   |: :::: : ::    ::::  :::    :.  :: .::: : ::    :.::  :::    ::  :: ::.. : ::    ::::  :::    ::  :. ::.: : ::    :.::  .::
   |.  ::  . :     .::.  :::    :   ::  :.:   :     :.:   :..        :  :.   . :.    :  :  : .    :   :  :  : :       :  :   ..
   |    .    :      :.   :.         .:        .           :             :      :     .  .  .      :   .  .            .  .   
   .         .           .           .                                         .                  .                               

-------------------------------------------------------------------------------------------------------------------------------

   .         .           .           .                                         .                  .                               
   :    .    :      :.   :.         .:        .           :             :      :     .  .  .      :   .  .            .  .   
   :.  ::  . :     .::.  :::    :   ::  :.:   :     :.:   :..        :  :.   . :.    :  :  : .    :   :  :  : :       :  :   ..
   :: :::: : ::    ::::  :::    :.  :: .::: : ::    :.::  :::    ::  :: ::.. : ::    ::::  :::    ::  :. ::.: : ::    :.::  .::
   :: :::: :.::.   ::::..:::  ..::  :: :::: :.::.   ::::..:::  ..::  :: :::: :.::.   ::::..:::  ..::  :: :::: :.::.   ::::..:::
|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|
18    1/2    17     1/2    16     1/2    15     1/2    14     1/2    13     1/2    12     1/2    11     1/2    10     1/2     9
22           21            20            19            18            17            16            15            14            13

 0_04 -
      |_____
      /___.
      |_____
      /____
      |___
      /__
  1/2 -
      |_
      /.
      |_
      /__
      |___
      /____
 1_05 -
      |_____
      /_____
      |____
      /___
      |__
      /_
  1/2 -
      |.
      /
      |
      /
      |
      /
 2_06 -
      |
      /
      |
      /
      |
      /
  1/2 -
      |
      /
      |
      /
      |
      /
 3_07 -
      |
      /
      |
      /
      |
      /
  1/2 -
      |
      /
      |
      /
      |
      /
 4_08 -
      |
      /
      |
      /
      |
      /
  1/2 -
      |
      /
      |
      /
      |
      /
 5_09 -
      |
      /
      |
      /
      |
      /
  1/2 -
      |
      /
      |
      /
      |
      /
 6_10 -
      |
      /
      |
      /
      |
      /
  1/2 -
      |
      /
      |
      /
      |
      /
 7_11 -
      |
      /
      |
      /
      |
      /
  1/2 -
      |
      /
      |
      /
      |
      /
 8_12 -
      |
      /
      |
      /
      |
      /
  1/2 -
      |
      /
      |
      /
      |
      /
 9_13 -



---

Tue  2 Jun 2026 11:21:54 CEST

- ogni x minuti/secondi si esegue un controllo ed in base al risultato di questo controllo si esegue eventualmente qualcosa
    - controlli da fare
        - [time_idle] > [PERIOD_INACTIVITY]
            - l'operatore è lontano dalla postazione
            - quindi è iniziato il periodo di pausa
                - registrare questo evento di inzio pausa
        - dall'ultimo controllo c'è stato un reset del [time_idle]
            - analisi del [PERIOD_INACTIVITY]
 |    
 |.:  
 |.: : 
 |.: : 
 |.:P::   
|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|
0      1      2      3      4      5      6      7      8      9      0      1      2      3      4      5      6      7      8
04     05     06     07     08     09     10     11     12     13     14     15     16     17     18     19     20     21     22


|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|
0      1      2      3      4      5      6      7      8      9      0      1      2      3      4      5      6      7      8
04     05     06     07     08     09     10     11     12     13     14     15     16     17     18     19     20     21     22

|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|
9      0      1      2      3      4      5      6      7      8
13     14     15     16     17     18     19     20     21     22


|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|
0     1/2     1     1/2     2     1/2     3     1/2     4     1/2     5     1/2     6     1/2     7     1/2     8     1/2     9
04            05            06            07            08            09            10            11            12            13


|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|-_-_-_|
0     1/2     1     1/2     2     1/2     3     1/2     4     1/2     5     1/2     6     1/2     7     1/2     8     1/2     9
13            14            15            16            17            18            19            20            21            22

142536364;[activity_event_start]
142538765(fine dell'[activity_period] = ultimo [activity_event] = inizio dell'[idle]); numero [activity_event]
142538765;[idle] (maggiore o uguale a 5 miniuti) (l'[idle] è l'intervallo di tempo tra due [activity_event] l'ultimo ed il primo di due serie di [activity_event])
142536364;(fine [idle]) [activity_event]

- domanda/dubbio
    - quando il sistema è in [sleep] l'idle time si ferma oppure continua ad essere incrementato?
        - in particolare lo script in backgrouind che è stao avviato viene eseguito?

- idle e activity event vanno a coppie nel senso che si registra l'[idle] quando viene rilevato un [activity_event]
    - quando si rileva un [activity_event] 
        - si controlla l'[idle] 
            - se è maggiore o uguale a 5 minuti
                - lo si regsitra
                - il conatotre degli [activity_event] viene resettato/azzerato
                    - e lo si registra
            - altrimenti
                - il conatotre degli [activity_event] viene incrementato
    -



---

Fri 22 May 2026 07:07:43 CEST

- statistiche
    - intervallo di [idle_pensiero]
        - sono intervalli di tempo identificati da un tempo di idle compreso tra 10 secondi e 2 minuti
    - intervalli di idle maggiori di 2 minuti
        - N.B. questo tempo identifica i momenti in cui l'utente sta pensando/ragionando su cosa fare
    - [eventi_utente]
        - identifica il mmomento in cui l'utente sta scrivendo, ci deve essere un [reset_idle] almeno ogni secondo per più di 5 secondi
    - tempo più lungo di periodo di attività (ammessi tempi di idle inferirori a 10 secondi)
    - [activity_period]
        - identifica l'intervallo in cui sono presenti [writing_period] con tempi di idle tra questi periodi non maggiori di 10 secondi
    - [writing_period] 
        - identifica l'intervallo in cui si sono verificati [reset_idle] almeno ogni secondo
        - il [writing_period] si incrementa ogni volta che il [time_idle] è inferiore ad 1 secondo, altrimenti si riazzera
        - il numero di periodi di scrittura
            - si incrementa quando il periodo di scrittura supera i 5 secondi
        - media dei periodi di scrittura = ammonmtare dei periodi di scrittuera / il numero di periodi di scrittura
    - [inactivity_period_2_4]
    - [inactivity_period_4_6]
    - [inactivity_period_6_10]
        - [inactivity_period_2_4] rappresenta un periodo di idle maggiore di 2 minuti e minore di 4 minuti
            - si possono conteggiare 
            - e fare una media dei periodi di inattività 
        - un periodo di 10 minuti di inattività viene considerata una pausa
    - intervalli tra periodi di attività 
        - vedere [idle_pensiero]
    - intervallo di [idle_pensiero] più lungo e media degli intervalli di [idle_pensiero] tra due periodi di attività
        - N.B.: il valore minimo di questo intervallo sara naturalente compreso 10 secondi e 2 minuti

---

Thu 21 May 2026 10:13:53 CEST

- come organizzare l'applicativo del registro ore
    - [regAct_bkg.sh] -> processo in background che eseguirà quanto segue
        - controllo della corrispondenza tra l'attività impostata e la presenza di attività sul pc
    - [regAct_db.txt] -> file di testo che rappresenta il database del registro ore
        - questo registro
    - [regAct_list.txt] -> file di testo che ha la lista del nome di tutte le attività
    - [regAct_prmp.sh] -> applicazione di interfaccia con l'utente
        - aggiornare il registro ore
        - rispondere alle richieste del processo in background
        - controllare la coerenza tra richiesta del processo in background e risposta dell'utente
    - [regAct_chat.txt] -> file di testo che tiene traccia dell'interazione tra utente e processo in background
- gestione eventi
    - la gestione degli eventi è implementata nel processo in background [regAct_bkg.sh] in particolare
        - aggiornamento e controllo dello stato dei timer
    - i timer coinvolti nella gestione degli eventi sono
    - quando i timer raggiungono lo zero scatta l'evento ovvero le funzioni di handler vengono eseguite
        - timer di idle [tmr_idle]
            - [tmr_idle] = <tmr_idle_max> - [HIDIdleTime]
                - se per [time_max_inactivity] (= <tmr_idle_max>) secondi l'utente non fa niente allora si può dire che non ci sia attività e quindi che l'utente non sia presente
        - timer di attività [tmr_activity]
            - [tmr_activity]--                          quando [HIDIdleTime] <  <tmr_activity_reset>
            - [tmr_activity] = <tmr_activity_period>    quando [HIDIdleTime] >= <tmr_activity_reset>
                - se per <tmr_activity_period> secondi c'è almeno un azione dello user (reset del [HIDIdleTime]) ogni <tmr_activity_reset> secondi allora scatta l'evento [activity_event]
                - ovvero si può dire che l'utente sia attivo
    - le funzioni (gli handler) associate agli eventi sono eseguite dal processo in background

- registrare la frequenza di attività
    - quante volte viene eseguito il reset del [HIDIdleTime]
        - se [time_polling]+[HIDIdleTime_old] > [HIDIdleTime]  allora c'è stato un reset
        - se [time_polling]+[HIDIdleTime_old] <= [HIDIdleTime] allora non c'è stato alcun reset
            - per i successivi se [time_polling] > [HIDIdleTime]  allora c'è stato un reset
        - più semplicemente
            - se [time_polling] > [HIDIdleTime]  allora c'è stato un reset
            - N.B.: in questo modo forse si potrebbero perdere dei reset
        - contatore dei reset del [HIDIdleTime] con intervallo di reset [tmr_idle_reset_range] (significa che se c'è più di un reset all'interno di questo intervallo viene conteggiato come uno unico)
    - tempo massimo di inattività

---

Wed 20 May 2026 06:37:11 CEST


- comandi da dare allo script
    - comandi di scrittura
        - -a <attività> -s <inizio attività, solo ortario, la data viene acquisita automaticamnete> -l <durata attività>
    - comandi di report
        - -r <attività> -d <giorno>
            - da la durata dell'attività il giorno specificato
        - -r <attività> -w <week>
            - fornisce la durata giornaliera dell'attività nei sette giorni della settimana specioficata
        - -r <attività> -m <week>
            - fornisce la durata giornaliera dell'attività nei giorni del mese specificato
- use case
    - si va in pausa e si cambia lo stato da work a pause
        - si ritorna dalla [pausa_pranzo]
        - lo script rileva attività e chiede di confermare l'attivita precedentemente impostata e di inserire l'attività che si sta iniziando a svolgere in quel momento
            - se l'utente non risponde il sistema imposta lo stato di UNKNOWN e conferma l'attività di pausa solo per il tempo di default associato all'attività
    - si va in pausa e ci si dimentica di impostare lo stato in [pausa]
        - il sistema quando vede che non c'è attività si porta nello stato di [UNKNOWN]
            - si ritorna dalla [PAUSA]
                - il sistema vede che c'è attività e chiede di inserire le attività svolte in questo periodo di inattività e quindi sostituire lo stato di [unknown]
                    - N.B.: non deve esserci nessuno stato di [UNKNOWN]

- struttura dati del registro ore
    - <attività>; <start date & time in seconds>; <Wed 20 May 2026 06:37:11>; <durata attività>
- report sui dati registrati
    - <giorno>; <attività>; <durata attività>; <media della durata giornaliera dell attività negli ultimi 7gg>

- elenco attività svolte durante il giorno
    - <nick name>; <PC con (Y) o senza (N)>; <Type Work (W) o Pause (P)>; <attività>
    - W; Y; smth_YW;        work > something > with PC
    - W; y; office;         work > office task
    - W; y; bang;           work > office task > bang;
    - W; y; outgoing;       work > office task > outgoing;
    - W; Y; mpfw_C;         work > project > mpfw > code > c_c++
    - W; Y; mpfw_M;         work > project > mpfw > code > cMake
    - W; Y; mpfw_S;         work > project > mpfw > code > shell
    - W; Y; mpfw_gH;        work > project > mpfw > admin > github
    - W; Y; mpfw_g;         work > project > mpfw > admin > git
    - W; N; mpfw_gH;        work > project > mpfw > hw
    - W; N; smth_NW;        work > something > without PC
    - W; N; house;          work > house > keeping
    - W; N; kitchen;        work > house > keeping > kitchen
    - W; N; bath;           work > house > keeping > bath

    - P; Y; smth_YP;        pause > something > with PC
    - P; Y; nap;            pause > free time > nap
    - P; Y; medit;          pause > free time > meditation
    - P; Y; book;           pause > free time > reading > book
    - P; Y; volantini;      pause > free time > reading > volantini
    - P; N; smth_NP;        pause > something > without PC
    - P; N; face;           pause > toilet > personal hygiene > daily hygiene
    - P; N; shower;         pause > toilet > personal hygiene > body hygiene
    - P; N; teeth;          pause > toilet > personal hygiene > teeth hygiene
    - P; N; feet;           pause > toilet > personal hygiene > feet hygiene
    - P; N; bidet;          pause > toilet > personal hygiene > bidet
    - P; N; relieve;        pause > toilet > relieve myself
    - P; N; cook & meals;   pause > food > cooking & having meals
    - P; N; water;          pause > food > having water
    - P; N; garden;         pause > health > vegetable garden
    - P; N; court;          pause > health > courtyard
    - P; N; body build;     pause > health > fitness > body building
    - P; N; bike;           pause > health > fitness > bike
    - P; N; walk;           pause > health > fitness > walk
    - P; Y; shop web;       pause > shopping > web
    - P; Y; amazon;         pause > shopping > web > amazon
    - P; N; shop food;      pause > shopping > food
    - P; N; shop tulip;     pause > shopping > house > tulipano
    - P; N; shop brico;     pause > shopping > house > brico
    - P; N; shop clothes;   pause > shopping > clothes
    
    


    - what i am working on
        - something
        - with PC
            - default
            - office task
            - project -> length 30 minutes
                - <project name>
                    - c/c++
                    - cmake
                    - shell
                    - admin
        - without PC
            - office task
                - outgoing
            - project
                - <project name>
                    - hw
            - house
                - keeping
    - what i am doing a pause on
        - something
        - with PC
            - volantini supermercati    -> length 15 minutes
            - reading                   -> length 15 minutes
        - without PC
            - toilet
                - personal hygiene
                    - daily hygiene
                    - body hygiene
                    - teeth hygiene
                - relieve myself (to relieve oneself / o.s.) / (to urinate or to empty bowels)
            - default
            - mamma
            - meals & cooking       --> length 120 minutes
            - water
            - fitness
            - meditation
            - nap
            - volantini supermercati
            - reading


---

Tue 19 May 2026 06:31:38 CEST

- gli stati/attività sono di TRE tipi
    - di init
        - è lo stato di LOGGED
            - questo è uno stato temporaneo l'utente necessariamente lo deve aggiornare ad uno stato stabile
    - unknown
        - unknown_ON
            - associato all'evento ACTIVITIES_RUN
                - il timer associato a questo evento dice quanti secondi sono passati dall'ultimo evento IDLE 
                - il tempo associato a questo evento deve naturalmente essere maggiore del tempo max di IDLE 
                - c'è attività se il tempo di idle è minore di un tempo fissato
                    - quando il tempo di idle (ottenuto dal sistema) è superiore ad un tempo fissato significa che non c'è attività e quindi il timer dell'evento ACTIVITIES_RUN viene ricaricato
                    - quando il tempo di idle è inferiore ad un tempo fissato il timer dell'evento ACTIVITIES_RUN viene decrementato
                    - N.B.: se questo tempo fissato è inferiore al tempo associato all'evento IDLE può avvenire che il sistema non avra mai ne l'evento di ACTIVITIES_RUN ne l'evento di IDLE
                        - se il tempo di idle si azzera quando si trova tra i due tempi fissati associati agli eventi ACTIVITIES_RUN e IDLE 
                            - allora entrambi i timer dei due eventi vengono ricaricati e quindi non arriveranno mai a "scattare" 
                            - ovvero il sistema non può dire che c'è attività ma neanche può dire che ci si trova in uno stato di IDLE
                    - rimane sotto un valore fissato di idle per n-secondi allora scatta l'evento ACTIVITIES_RUN
                        - si accetta che ci sia attività se il tempo di idle non supera un valore fissato
                            - se la velocità con cui si svolgono le attività è superiore ad un valore fissaato
                        - c'è un attività continuativa se c'è attività per almeno un tempo fissato
        - unknown_OFF
            - associato all'evento IDLE
                - il timer asociato a questo evento è il complementare del tempo di IDLE, che si ottiene con uno speciifico comando di sitema, rispetto ad un limite massimo di idle
                    - ovvero dopo n_max secondi di idle scatta questo evento
        - anche questo è uno stato temporaneo l'utente necessariamente lo deve aggiornare ad uno stato stabile
            - se l'utente non risponde viene impostato lo stato di default corrispondente ad un vento UNKNOWN_ON
    - con PC
        - quando si verifica l'evento IDLE_START in uno stato [con_PC] si passa ad uno stato di UNKNOWN
    - senza PC
        - quando si verifica l'evento IDLE_STOP in uno stato [senza_PC] si passa in uno stato di UNKNOWN
- gestione eventi
    - l'evento di IDLE viene gestito quando lo stato corrente è [con_PC]
        - il timer dell'IDLE si "ricarica" aautomaticamente
    - l'evento di ACTIVITIES_RUN viene gestito quando lo stato corrente è [senza_PC]
        - il timer dell'ACTIVITIES_RUN si ricarica ogni volta che il tempo di idle ottenuto dal sistema è superiore ad un certo valore che determinata la velocità minima con cui si devono svolgere le attività affinche siano significative


- stat: STATE (init to <logged> state)
- scrp: have you begun to work? (every 2 minutes up to ACTIVITIES events)
    - evnt: USER (user writes --> [yes])
        - stat: STATE (update to <work> state)
        - scrp: ok, now you are in <work> state; 
        - scrp: what are you working on? (every 2 minutes up to ACTIVITIES events)
            - evnt: USER (user writes --> [mpfw,c++])
                - stat: OBJ (update to <mpfw,c++> obj)
                - scrp: ok, you are working on <mpfw c plus plus code> now
            - evnt: ACTIVITIES but user does not answer anything (ACTIVITIES for at least 10 minutes without any user answer)
                - stat: OBJ (update to <something> obj)
                - scrp: ok, you are working on <something> now
    - evnt: USER (user writes --> [no])
        - stat: STATE (update to <pause> state)
        - scrp: ok, now you are in <pause> state; 
        - scrp: what is the object of your pause? (every 2 minutes up to ACTIVITIES events)
            - evnt: USER (user writes --> [reading]) 
                - stat: OBJ (update to <reading> obj)
                - scrp: ok, you are in pause, the object of pause is <reading> now
            - evnt: ACTIVITIES but user does not answer anything (ACTIVITIES for at least 10 minutes without any user answer)
                - stat: OBJ (update to <something> obj)
                - scrp: ok, you are in pause, the object of pause is <something> now
    - evnt: USER (user writes --> <state name>)
        - stat: STATE (update to <state name> state)
        - scrp: ok, now you are in <state name> state; 
    - evnt: USER (user writes --> [?state])
        - scrp: now you are in <state name> state; 
    - evnt: ACTIVITIES_RUN but user does not answer anything (ACTIVITIES for at least 10 minutes without any user answer)
        - stat: STATE (update to <unknown_ON> state)
        - scrp: ok, now you are in an <unknown_ON> state
        - scrp: you are in an unknown state for <number of minutes - example: 40> minutes ... can you tell me what have you done, till now? (every 2 minutes)
            - evnt: USER (user writes --> [pause_10] (in pausa per 10 minuti))
                - stat: OLD_STATE (update to <pause> state)
        - scrp: you are in an unknown state for <number of minutes - example: 30> minutes ... can you tell me what have you done, till now? (every 2 minutes)
            - evnt: USER (user writes --> [house_30] (lavoro per 30 minuti))
                - stat: OLD_STATE (update to <work> state)
    - evnt: IDLE (no ACTIVITIES for at least 5 miniutes)
        - stat: STATE (update to <unknown_OFF> state)
        - scrp: ok, now you are in an <unknown_OFF> state
            - evnt: ACTIVITIES_NEW
            - scrp: you are in an unknown state <number of minutes - example: for 40 minute since ... > ... can you tell me what have you done, till now? (every 2 minutes)

            
            - scrp: are you still working?
                - user: no
                    - scrp: ok, now you are in pause
                    - evnt: activities
                        - scrp: are you still in <pause>? (every 2 minutes)
                            - user: no / work
                                - scrp: have you come back to work on <mpfw c plus plus code>? (every 2 minutes)
                                    - user: no
                                        - scrp: what are you working on then?
                                            - user: mpfw, hw
                                                - scrp: ok, you are working on mpfw c plus plus code now
                - user: (no actiivities for 2 minutes)
                    - scrp: ok, now you are in an unknown state
                    - evnt: activities
                        - scrp: you are in an unknown state for <number of minutes - example: 40> minutes ... can you tell me what have you done, till now? (every 2 minutes)
                            - user: pause 10 (in pausa per 10 minuti)
                        - scrp: you are in an unknown state for <number of minutes - example: 30> minutes ... can you tell me what have you done, till now? (every 2 minutes)
                            - user: house 30 (in pausa per 10 minuti)
                        - scrp: you are in an unknown state since <number of minutes> minutes ... can you tell me what have you done, till now? (every 2 minutes)
                            - user: pause 10 (in pausa per 10 minuti)

- status
    - logged        --> work, pause, unknown_ON, unknown_OFF
    - work          --> pause, unknown_ON
    - pause         --> work, unknown_OFF
    - unknown_ON    --> pause, work
    - unknown_OFF   --> pause, work

    - logged    --> work, pause, unknown
    - work      --> pause, unknown
    - pause     --> work, unknown
    - unknown   --> pause, work
- object status
    - what i am working on
        - something
        - with PC
            - default
            - office task
            - project -> length 30 minutes
                - <project name>
                    - c/c++
                    - cmake
                    - shell
                    - admin
        - without PC
            - office task
                - outgoing
            - project
                - <project name>
                    - hw
            - house
                - keeping
    - what i am doing a pause on
        - something
        - with PC
            - volantini supermercati    -> length 15 minutes
            - reading                   -> length 15 minutes
        - without PC
            - toilet
                - personal hygiene
                    - daily hygiene
                    - body hygiene
                    - teeth hygiene
                - relieve myself (to relieve oneself / o.s.) / (to urinate or to empty bowels)
            - default
            - mamma
            - meals & cooking       --> length 120 minutes
            - water
            - fitness
            - meditation
            - nap
            - volantini supermercati
            - reading






---

Mon 18 May 2026 16:03:07 CEST


$ read -t 5 input_string
// waiting 5 seconds for an input from stdin

$ date +%s
output: 1779090752

$ date -r "1779090752"
output: Mon 18 May 2026 09:52:32 CEST

$ date -u  -r 180  "+TIME: %H:%M:%S" 
output: TIME: 00:03:00

$ date -u  -r 180  -v -1S "+TIME: %dg %H:%M:%S" 
output: TIME: 01g 00:02:59

work@umtiefs-Mac-mini scrp % ioreg -c IOHIDSystem | sed -e '/HIDIdleTime/!{ d' -e 't' -e '}' -e 's/.* = //g' -e 'q'
31538979

work@umtiefs-Mac-mini scrp % ioreg -c IOHIDSystem
...
...
 | |       +-o Trackpad / Boot@1  <class AppleUSBInterface, id 0x100000873, registered, matched, active, busy 0 (0 ms), retain 5>
    | |       +-o Actuator@2  <class AppleUSBInterface, id 0x100000874, registered, matched, active, busy 0 (0 ms), retain 5>
    | |       +-o Accelerometer@3  <class AppleUSBInterface, id 0x100000876, registered, matched, active, busy 0 (0 ms), retain 5>
    | +-o com_apple_AppleFSCompression_AppleFSCompressionTypeDataless  <class com_apple_AppleFSCompression_AppleFSCompressionTypeDataless, id 0x1000004b6, !registered, !matched, active, busy 0, retain 4>
    | +-o com_apple_AppleFSCompression_AppleFSCompressionTypeZlib  <class com_apple_AppleFSCompression_AppleFSCompressionTypeZlib, id 0x1000004b7, !registered, !matched, active, busy 0, retain 4>
    | +-o AppleImage4  <class AppleImage4, id 0x1000004b8, registered, matched, active, busy 0 (0 ms), retain 5>
    | +-o AppleMobileFileIntegrity  <class AppleMobileFileIntegrity, id 0x1000004b9, registered, matched, active, busy 0 (3 ms), retain 7>
    | +-o AppleGCResource  <class AppleGCResource, id 0x1000004ba, registered, matched, active, busy 0 (0 ms), retain 7>
    | | +-o AppleGCResourceDeviceUserClient  <class AppleGCResourceDeviceUserClient, id 0x1000008c8, !registered, !matched, active, busy 0, retain 6>
    | +-o AppleSystemPolicy  <class AppleSystemPolicy, id 0x1000004bb, registered, matched, active, busy 0 (0 ms), retain 8>
    | | +-o AppleSystemPolicyUserClient  <class AppleSystemPolicyUserClient, id 0x10000068f, !registered, !matched, active, busy 0, retain 5>
    | | +-o AppleSystemPolicyUserClient  <class AppleSystemPolicyUserClient, id 0x100000692, !registered, !matched, active, busy 0, retain 5>
    | +-o com_apple_BootCache  <class com_apple_BootCache, id 0x1000004bc, !registered, !matched, active, busy 0, retain 4>
    | +-o com_apple_filesystems_hfs  <class com_apple_filesystems_hfs, id 0x1000004bd, !registered, !matched, active, busy 0, retain 4>
    | +-o com_apple_filesystems_hfs_encodings  <class com_apple_filesystems_hfs_encodings, id 0x1000004be, !registered, !matched, active, busy 0, retain 4>
    | +-o IOHIDResource  <class IOHIDResource, id 0x1000004bf, registered, matched, active, busy 0 (0 ms), retain 5>
    | +-o IOHIDSystem  <class IOHIDSystem, id 0x1000004c0, registered, matched, active, busy 0 (7 ms), retain 15>
    | | | {
    | | |   "IOClass" = "IOHIDSystem"
    | | |   "HIDScrollCountMaxTimeDeltaBetween" = 600
    | | |   "IOPersonalityPublisher" = "com.apple.iokit.IOHIDFamily"
    | | |   "IOResourceMatch" = "IOBSD"
    | | |   "IOMatchedAtBoot" = Yes
    | | |   "HIDServiceGlobalModifiersUsage" = 1
    | | |   "IOProviderClass" = "IOResources"
    | | |   "IOReportLegendPublic" = Yes
    | | |   "IOProbeScore" = 0
    | | |   "HIDIdleTime" = 40165394
    | | |   "HIDScrollCountIgnoreMomentumScrolls" = Yes
    | | |   "HIDScrollCountAccelerationFactor" = 163840
    | | |   "HIDServiceSupport" = Yes
    | | |   "HIDScrollCountMouseCanReset" = Yes
    | | |   "IOCFPlugInTypes" = {"0516B563-B15B-11DA-96EB-0014519758EF"="IOHIDFamily.kext/Contents/PlugIns/IOHIDNXEventRouter.plugin"}
    | | |   "VendorID" = 1452
    | | |   "CFBundleIdentifierKernel" = "com.apple.iokit.IOHIDFamily"
    | | |   "HIDScrollCountMinDeltaToSustain" = 20
    | | |   "IOMatchCategory" = "IOHID"
    | | |   "CFBundleIdentifier" = "com.apple.iokit.IOHIDFamily"
    | | |   "HIDScrollCountBootDefault" = {"HIDScrollCountMinDeltaToStart"=30,"HIDScrollCountAccelerationFactor"=163840,"HIDScrollCountMouseCanReset"=Yes,"HIDScrollCountIgnoreMomentumScrolls"=Yes,"HIDScrollCountMinDeltaToSustain"=20,"HIDScrollCountMax"=2000,"HIDScrollCountMaxTimeDeltaBetween"=600,"HIDScrollCountMaxTimeDeltaToSustain"=250}
    | | |   "PrimaryUsage" = 23
    | | |   "CursorState" = {"LastMoveCursor (Seconds ago)"="20560.846486","LastShowCursor (Seconds ago)"="20560.838863","LastHideCursor (Seconds ago)"="20560.838876"}
    | | |   "HIDPowerOnDelayNS" = 500000000
    | | |   "IOGeneralInterest" = "IOCommand is not serializable"
    | | |   "PrimaryUsagePage" = 65280
    | | |   "HIDScrollCountMinDeltaToStart" = 30
    | | |   "HIDScrollCountMaxTimeDeltaToSustain" = 250
    | | |   "IOReportLegend" = ({"IOReportGroupName"="Cursor","IOReportChannels"=((4860917212932887663,64426082307,"Cursor Total Latency")),"IOReportChannelInfo"={"IOReportChannelConfig"=<6400000000000000000000000a000000204e0000000000000100000005000000>,"IOReportChannelUnit"=72058113728970752},"IOReportSubGroupName"="Total"},{"IOReportGroupName"="Cursor","IOReportChannels"=((4860917212932884338,64426082$
    | | |   "HIDParameters" = {"HIDMouseKeysOptionToggles"=0,"JitterNoClick"=1,"ActuateDetents"=1,"Dragging"=0,"HIDSlowKeysDelay"=0,"JitterNoMove"=1,"TrackpadThreeFingerHorizSwipeGesture"=2,"HIDInitialKeyRepeat"=500000000,"TrackpadThreeFingerDrag"=No,"HIDPointerAcceleration"=45056,"UserPreferences"=Yes,"HIDDefaultParameters"=Yes,"TrackpadHorizScroll"=1,"HIDF12EjectDelay"=250,"TrackpadFourFingerVertSwipe$
    | | |   "HIDScrollCountMax" = 2000
    | | | }
    | | | 
    | | +-o IOHIDUserClient  <class IOHIDUserClient, id 0x100000780, !registered, !matched, active, busy 0, retain 5>
    | | +-o IOHIDEventSystemUserClient  <class IOHIDEventSystemUserClient, id 0x100000793, !registered, !matched, active, busy 0, retain 5>
    | | +-o IOHIDParamUserClient  <class IOHIDParamUserClient, id 0x1000007e7, !registered, !matched, active, busy 0, retain 5>
    | | +-o IOHIDParamUserClient  <class IOHIDParamUserClient, id 0x100000808, !registered, !matched, active, busy 0, retain 5>
    |
...
...

work@umtiefs-Mac-mini scrp % ioreg -c IOHIDSystem | grep HIDIdleTime
    | | |   "HIDIdleTime" = 31068206


1.000.000.000

repeat 3600 { echo $(date) "-" $((`ioreg -c IOHIDSystem | sed -e '/HIDIdleTime/!{ d' -e 't' -e '}' -e 's/.* = //g' -e 'q'`/1000000000)) "seconds idle"; sleep 1 }
