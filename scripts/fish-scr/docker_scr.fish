alias cls_doc_img="docker images -a | awk 'NR>1 {system(\"docker images rm \"\$1)}'"
alias cls_doc_con="docker ps -a | awk 'NR>1 {system(\"docker rm \"\$1)}'"
alias kill_doc_con="docker ps -a | awk 'NR>1 {system(\"docker kill \"\$1)}'"
alias stop_doc_con="docker ps -a | awk 'NR>1 {system(\"docker stop \"\$1)}'"
alias dock_killexit="docker ps -a | awk 'NR>1 {system(\"docker stop \"\$1\" && docker rm \"\$1)}"
