#!/bin/bash

# 部署指定分支的指定模块

svnno=$1
module=$2
password=Cshj@2014
isLegalModule=false

# 入参校验
if [[ -z "$svnno" ]]; then
	echo "============= 请输入要部署的版本号 [e.g. 5.0.13] ============="
	exit 1;
fi
if [[ -z "$module" ]]; then
	echo "============= 请输入要部署的模块名字 [e.g. fund homeChanels] ============="
	exit 1;
fi
for moduleName in $(cat moduleConfig); do
	if [[ "$module" = "$moduleName" ]]; then
		isLegalModule=true
	fi
done
if [[ ! "true" = "$isLegalModule" ]]; then
	echo "============= 输入的模块名字不合法 请确认 ============="
	exit 1;	
fi
ROOT=$HOME/subversion/Branch_mobappFront_$svnno
if [[ ! -d "$Root" ]]; then
	echo "============= Branch_mobappFront_$svnno 不存在，请执行[ ./getCode.sh $svnno ] 获取 ============="
	exit 1;	
fi
if [[ -f $Home/version/Branch_mobappFront.zip ]]; then
	rm -f $Home/version/Branch_mobappFront.zip
fi

# 执行本地打包并进行压缩
echo "============= 模块 $module 正在打包 ============="
if [[ "homeChanels" = "$module" ]]; then
	cd $Root
	svn up
	# 准备公共文件
	cp -r $Root/packages/@public/lib-public .
	cp -r $Root/packages/@public/lib-project .
	cp -r $Root/packages/@public/lua .
	# 打包homeChanels
	cd $Root/packages/$module
	pnpm run build:test_relative-path
else
	cd $Root/packages/$module
	svn up
	pnpm run build:test
fi
cd $HOME/version
cp -r $Root/packages/$module/dist ./$modules
zip -r Branch_mobappFront.zip ./*

# 发送到前端服务器，并执行部署
expect <<- EOF
set timeout 10000
spawn scp Branch_mobappFront.zip nginx@203.3.131.186:install
expect{
	"yes/no" { send "yes\n";exp_continue }
	"*password" { send "$password\n" }
} 
sleep 3
send "Each transfer successfully!"
expect eof
EOF

expect <<- EOF
set timeout 10000
spawn ssh nginx@203.3.131.186 "cd install;sh install.shs"
expect{
	"yes/no" { send "yes\n";exp_continue }
	"*password" { send "$password\n" }
} 
sleep 3
send "Each transfer successfully!"
expect eof
EOF

# 删除临时文件
rm -rf $module
if [[ "homeChanels" = "$module" ]]; then
	rm -rf l*
fi
echo "============= 前端打版完成 ============="















