alias cls-doc-img="docker images -a | awk 'NR>1 {system(\"docker images rm \"\$1)}'"
alias cls-doc-con="docker ps -a | awk 'NR>1 {system(\"docker rm \"\$1)}'"
