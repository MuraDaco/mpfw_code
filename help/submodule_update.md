
- how to import new submodules created in another repository (for example by your collegue)
    - $ git submodule update --init
        - for more details see "progit.pdf" file (git manual) at pg. 304-305 (Chapter "Submodules", Paragraph "Working on a Project with Submodules / Pulling Upstream Changes from the Project Remote")
            - if new imported submodules have submodules inside, you can use
                - $ git submodule update --init --recursive 

