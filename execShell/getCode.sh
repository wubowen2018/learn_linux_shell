#!/bin/bash

# 获取指定分支的前端代码
# 如果代码已经存在就跟新并安装依赖
# 如果代码不存在就svn co 检出并安装依赖

svnno=$1
if [[ -z "$svnno" ]]; then
	echo "================ 请输入版本号 [ e.g.  5.0..13 ] ================"
	exit 1;
fi

cd $HOME/subversion/
newCodePath=Branch_mobappFront_$svnno

if [[ -d "$newCodePath" ]]; then
	echo "================ $newCodePath is already exists! running [ svn up ] ================"
	cd $HOME/subversion/$newCodePath
	svn up
else
	svn co http://ip/svn/mobileebank/branches/$newCodePath
fi

cd $HOME/subversion/$newCodePath

echo "================ running [ pnpm i ] ================"
pnpm i
echo "================ All done! ================"




