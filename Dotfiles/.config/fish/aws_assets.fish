function aws-set-cred
	sed -e '/\[default\]/{n;N;N;N;d}' ~$USER/.aws/credentials 
end

function test-aws-set-cred
	set $1 (echo $1 | sed -e '/\[/{N;d}')
	sed -e '/\[default\]/{n;N;iN;N;d}'  ~$USER/.aws/test
	echo $1
end

function test-func
	echo instanciating
	echo (echo $1 | sed -e '/\[/{N;d}')
end

