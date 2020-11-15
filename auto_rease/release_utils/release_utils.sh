# 初始化配置信息
function fun_init_release_config {
	fun_ctrl_c_disable
	fun_init_release_user
	fun_init_server_user
	fun_init_app_locate
	fun_init_app_config
	fun_init_msg
	fun_init_cmd
}

# 检查当前服务器是否是打包服务器
function fun_check_release_device {
	ServerIP=`/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
	ServerUser=`whoami`

	if [ "$ServerIP" != `fun_get deploy_server_ip` ]; then
		echo "当前服务器不是打包服务器，程序退出！"
		fun_exit
	elif [ "$ServerUser" != `fun_get deploy_server_username` ]; then
		echo "不允许使用当前用户进行发布，请切换至"`fun_get deploy_server_username`"进行发布！"
		fun_exit
	fi
}

# 打印说明
function fun_print_readme {
	echo "##########################"
	echo "## 手机银行自动发布工作   "
	echo "## 作者：贺宇鹏           "
	echo "## 编写日期：2017-12-13   "
	echo "##########################"
	echo "○----------------------------○"
	echo "|      ./\   _               |"
	echo "| c ..'D> ·'//...........'·. |"
	echo "| :        //            :·  |"
	echo "| :       //             :   |"
	echo "| '..... //              :   |"
	echo "|  ^^^^^| :              ;   |"
	echo "|       ○ :             .'   |"
	echo "|         : :':'''''':·: ·.  |"
	echo "|         ''''··      ··'''  |"
	echo "○----------------------------○"
}

# 校验服务器时间
function fun_check_release_time {
	set `date "+%Y-%m-%d　%H:%M:%S"`

	Msg1="当前服务器时间：$1 \n"
	Msg2="服务器时间是否为自然时间？（按任意键继续）\n"
	Msg3="n->非自然时间"

	fun_print_msg $Msg1 $Msg2 $Msg3
	read Input
	fun_check_input quit $Input

	Release_Time=$1

	if [ "$Input" == "n" ]; then
		fun_server_date_set
	fi
}

# 校验发布人员
function fun_check_release_user {
	Msg1="请输入你的姓名拼音全拼："
	fun_print_msg $Msg1
	read Input
	fun_check_input quit $Input

	Check_Key=$Input"_status"
	Check_Result=`fun_get $Check_Key`
	
	Release_User=$Input

	if [ "$Check_Result" != "ok" ]; then
		echo "未授权的打包人员，请重新输入！"
		fun_check_release_user
	fi
}

# 选择代码版本
function fun_choose_release_version {
	Msg1="请选择发布代码版本。\n"
	Msg2="M->SIT\n"
	Msg3="1->SIT\n"
	Msg4="2->PRO\n"
	Msg5="3->TRL"
	
	fun_print_msg $Default_Tip_Message $Msg1 $Msg2 $Msg3 $Msg4 $Msg5
	read Input
	fun_check_input quit $Input

	if [ "$Input" == "1" ]; then
		Release_Code_Version="sit"
	elif [ "$Input" == "2" ]; then
		Release_Code_Version="pro"
	elif [ "$Input" == "3" ]; then
		Release_Code_Version="trl"
	else
		Release_Code_Version="sit"
	fi
	echo $Release_Code_Version
}

# 选择打包模式
function fun_choose_compile_style {
	Msg1="请选择代码编译范围?\n"
	Msg2="M->应用代码（mbank）\n"
	Msg3="1->应用代码（mbank）\n"
	Msg4="2->全部（ewp&mbank）"
	fun_print_msg $Default_Tip_Message $Msg1 $Msg2 $Msg3 $Msg4
	read Input
	fun_check_input quit $Input

	if [ "$Input" == "1" ]; then
		Release_Compile_Style="mbank"
	elif [ "$Input" == "2" ]; then
		Release_Compile_Style="mbank&ewp"
	else
		Release_Compile_Style="mbank"
	fi
	echo $Release_Compile_Style
	#如果EWP不用更新，需要检查EWP是否已经编译完成
}

# 选择并初始化发布服务器信息
function fun_choose_release_target {
	Msg1="请选择发布环境。\n"
	Msg2="M->发布　\"系统测试\"　　　　环境　>　10.20.182.33:4002\n"
	Msg3="1->发布　\"系统测试\"　　　　环境　>　10.20.151.93:4002\n"
	Msg4="2->发布　\"投产演练\"　　　　环境　>　10.20.158.38:4002\n"
	Msg5="3->发布　\"开发联调（24）\"　环境　>　10.20.152.24:4002\n"
	Msg6="4->发布　\"开发联调（26）\"　环境　>　10.20.182.33:4002"
	fun_print_msg $Default_Tip_Message $Msg1 $Msg2 $Msg3 $Msg4 $Msg5 $Msg6
	read Input
	fun_check_input quit $Input

	if [ "$Input" == "1" ]; then
		Release_SMBS_Target_Server="sit"
	elif [ "$Input" == "2" ]; then
		Release_SMBS_Target_Server="trl"
	elif [ "$Input" == "3" ]; then
		Release_SMBS_Target_Server="dev24"
	elif [ "$Input" == "4" ]; then
		Release_SMBS_Target_Server="dev26"
	else
		Release_SMBS_Target_Server="sit"
	fi
}

# 选择发布的网银环境
function fun_choose_service_address {
	Msg1="请选择连接后台的环境。\n"
	Msg2="M->SIT\n"
	Msg3="1->SIT\n"
	Msg4="2->挡版\n"
	fun_print_msg $Default_Tip_Message $Msg1 $Msg2 $Msg3 $Msg4
	read Input
	fun_check_input quit $Input

	if [ "$Input" == "1" ]; then
		Release_EBANK_Target_Server="sit"
	elif [ "$Input" == "2" ]; then
		Release_EBANK_Target_Server="simulator"
	else
		Release_EBANK_Target_Server="sit"
	fi
}

# 打印当前发布信息供发布人员确认
function fun_confirm_release_info {
	echo "##########################################################"
	echo "## 请确认发布信息，确认无误按任意键继续！"
	echo "----------------------------------------------------------"
	echo "|发布人员：　　"$Release_User
	echo "|发布时间：　　"$Release_Time
	echo "|发布环境：　　"$Release_SMBS_Target_Server
	echo "|连接后台：　　"$Release_EBANK_Target_Server
	echo "|发布代码：　　"$Release_Code_Version
	echo "|编译内容：　　"$Release_Compile_Style
	echo "----------------------------------------------------------"
	echo "##########################################################"
	echo ""

	Msg1="n->错误，重新选择。"
	
	fun_print_msg $Msg1
	read Input
	fun_check_input quit $Input

	if [ "$Input" == "n" ]; then
		fun_release_restart
	fi
}

# 执行发布
function fun_do_release {
	# 更新svn代码
	fun_svn_up smbs $Release_Compile_Style
	# 打包svn代码到执行目录
	fun_prepare_release_project
	# 编译
	fun_project_compile $Release_Compile_Style
	# 打包应用和框架
	fun_create_release_package
	# 停止远程服务
	fun_remote_server_control stop
	# 备份远程服务器上的Log、Xml、卡样图片、广告图片
	fun_remote_server_tmp backup
	# 更新远程服务器上的应用和框架包
	fun_remote_server_update
	# 还原远程服务器上备份的Log、Xml、卡样图片、广告图片
	fun_remote_server_tmp restore
	# 启动远程服务
	fun_remote_server_control start
	# 上传客户端包
	fun_client_package_upload
	# 启用ctrl+c
	fun_ctrl_c_enable
	echo "发布完成，请自行检查发布结果。"
}

# 检查当前服务器是否正在进行打包任务
function fun_check_release_lock {
	# 这里的-f参数判断$myFile是否存在  
	if [ ! -f "$ReleaseLockFile" ]; then
		# 创建锁文件
		touch $ReleaseLockFile
	else
		echo "当前服务器正在执行打包任务，请等待，程序退出！"
		Exit
	fi
}

# 按照固定格式打印信息
function fun_print_msg() {
	fun_print_line
	echo -e $1
	fun_print_line
	echo ""
	echo -e $2$3$4$5$6$7$8$9
	echo ""
	fun_print_line
	echo "q->退出发布程序"
	fun_print_line
}

# 上传
function fun_upload {
	# 目标服务器用户
	Remote_Server_User=`fun_get $Release_SMBS_Target_Server"_server_username"`
	# 目标服务器地址
	Remote_Server_IP=`fun_get $Release_SMBS_Target_Server"_server_ip"`
	# 1：当前文件路径
	# 2：目标服务器存放路径
	scp $1 $Remote_Server_User@$Remote_Server_IP:$2
}

# 远程命令
function fun_remote_shell {
	# 目标服务器用户
	Remote_Server_User=`fun_get $Release_SMBS_Target_Server"_server_username"`
	# 目标服务器地址
	Remote_Server_IP=`fun_get $Release_SMBS_Target_Server"_server_ip"`
	# 1：远程命令
	echo "远程命令：ssh $Remote_Server_User@$Remote_Server_IP $1 && exit"
	ssh $Remote_Server_User@$Remote_Server_IP "$1 && exit"
}

# 编译检查
function fun_check_compile_result {
	#SrcCounts=`ls -lR $1 | grep erl| wc -l`
	#BeamCounts=`ls -lR $2 | grep beam| wc -l`
	
	SrcCounts=`find $1 -name '*.erl' |wc -l`
	BeamCounts=`find $1 -name '*.beam' |wc -l`
	echo "目标文件数：$SrcCounts，编译文件数：$BeamCounts。"
	if [ "$SrcCounts" == "$BeamCounts" ]; then
		echo "编译成功，文件数匹配。"
	else
		echo "编译失败，文件数不匹配，请确认编译日志，退出！"
		fun_exit
	fi
}

# 更新环境地址配置
function fun_update_server_address {
	# 1：关键字
	Key_Words=$1
	# 2：操作文件
	Update_File=$2
	# 替换字段
	Replace_Content=`fun_get $Release_EBANK_Target_Server"_"$1"_address"`

	echo "Key_Words：$Key_Words"
	echo "Update_File：$Update_File"
	echo "Replace_Content：$Replace_Content"

	#sed -i 's/^        pbankhost.*$/        pbankhost = "10.20.113.94:9081\/pwweb\/"/g' ${file_to_sed} yaws.conf
	find $Update_File | xargs perl -pi -e 's|'$Key_Words' = ""|'$Key_Words' = "'$Replace_Content'"|g'
	fun_print_line
}

# 重新调用脚本
function fun_release_restart {
	# 释放锁后重新执行
	fun_release_lock
	cd $SMBS_Deploy_Location/ && sh ./$Release_Script_File_Name
}

# 准备发布包
function fun_prepare_release_project {
	if [ "$Release_Code_Version" == "sit" ]; then
		cd $SIT_Code_Location
	elif [ "$Release_Code_Version" == "pro" ]; then
		cd $PRO_Code_Location
	elif [ "$Release_Code_Version" == "trl" ]; then
		cd $TRL_Code_Location
	else
		fun_exit
	fi

	if [ "$Release_Compile_Style" == "mbank" ]; then
		tar cf mbank.tar mbank && mv mbank.tar $SMBS_Deploy_Location
		cd $SMBS_Deploy_Location && rm -rf mbank && tar xf mbank.tar && rm -f mbank.tar
	elif [ "$Release_Compile_Style" == "mbank&ewp" ]; then
		tar cf mbank.tar mbank && tar cf ewp.tar ewp && mv mbank.tar $SMBS_Deploy_Location && mv ewp.tar $SMBS_Deploy_Location
		cd $SMBS_Deploy_Location && rm -rf ewp && rm -rf mbank && tar xf ewp.tar && rm -f ewp.tar && tar xf mbank.tar && rm -f mbank.tar
	else
		echo "准备发布包失败，请检查！"
		fun_exit
	fi

	cd $SMBS_Deploy_Location
	# 删除svn缓存文件
	fun_delete_svn_tmp mbank
	fun_delete_svn_tmp ewp

	# 赋权限
	chmod -R 755 mbank/*
	chmod -R 755 ewp/*
}

# 编译发布包
function fun_project_compile {
	echo "编译App"
	cd $SMBS_Deploy_Location"mbank"
	$SMBS_APP_Configure > release.log
	$SMBS_APP_Clean_Compile > release.log
	$SMBS_APP_Compile > release.log

	if [ "$1" == "mbank&ewp" ]; then
		echo "编译Framework"
		cd $SMBS_Deploy_Location"ewp"
		$SMBS_Framework_Configure > release.log
		$SMBS_Framework_Clean_Compile > release.log
		$SMBS_Framework_Compile > release.log
	else
		echo "框架代码未编译！"
	fi

	# 应用编译检查
	fun_check_compile_result $SMBS_APP_Src_Location $SMBS_APP_Ebin_Location
	# 框架编译检查，暂定，后续修复
	#fun_check_compile_result $SMBS_Framework_Src_Location $SMBS_Framework_Ebin_Location
	
	fun_delete_sourcecode
}

# 删除源码
function fun_delete_sourcecode {
	rm -rf $SMBS_Deploy_Location"ewp/src"
	rm -rf $SMBS_Deploy_Location"mbank/src"
}

# 打包应用和框架
function fun_create_release_package {
	cd $SMBS_Deploy_Location
	tar cf ewp.tar ewp
	tar cf mbank.tar mbank
}

# 操作远程服务
function fun_remote_server_control {
	echo "操作远程服务。"
	fun_print_line
	if [ "$1" == "stop" ]; then
		fun_remote_shell "$SMBS_Server_Stop"
	elif [ "$1" == "start" ]; then
		fun_remote_shell "$SMBS_Server_Start"
	elif [ "$1" == "restart" ]; then
		fun_remote_shell "$SMBS_Server_Restart"
	else
		echo "错误的服务器控制命令，退出！"
		fun_exit
	fi
}

# 备份目标服务器的相关信息
function fun_remote_server_tmp {
	if [ "$1" == "backup" ]; then
		fun_remote_shell "$SMBS_Server_Tmp_Backup"
	elif [ "$1" == "restore" ]; then
		fun_remote_shell "$SMBS_Server_Tmp_Restore"
	else
		echo "错误的文件处理操作，退出！"
		fun_exit
	fi
}

# 更新远程服务器上的应用和框架包
function fun_remote_server_update {
	# 上传新包
	fun_upload $SMBS_Deploy_Location"ewp.tar" $SMBS_System_Install_Location
	fun_upload $SMBS_Deploy_Location"mbank.tar" $SMBS_System_Install_Location
	# 解压新包
	fun_remote_shell "$SMBS_App_Update"
	fun_remote_shell "$SMBS_Framework_Update"
	
	fun_remote_server_address_update
	fun_upload $SMBS_APP_File_Location"yaws.conf" $SMBS_APP_Install_Conf
	
	# 删除应用包
	cd $SMBS_Deploy_Location
	rm -f ewp.tar
	rm -f mbank.tar
}

# 更新远程服务器上的应用后台地址
function fun_remote_server_address_update {
	# 修改配置文件
	cd $SMBS_APP_File_Location
	cp smbs_app_yaws.conf yaws.conf
	fun_update_server_address "pbankhost"  "yaws.conf"
	fun_update_server_address "enbankhost" "yaws.conf"
	fun_update_server_address "qrcodehost" "yaws.conf"
	fun_update_server_address "maphost"    "yaws.conf"
	fun_update_server_address "infohost"   "yaws.conf"
}

# 上传客户端包
function fun_client_package_upload {
	if [ "$Release_Code_Version" == "sit" ]; then
		cd $SMBS_APP_Client_Package_Location
		fun_upload $SMBS_Android_Package_FileName $SMBS_Android_Package_Location
		fun_upload $SMBS_iPhone_Package_FileName $SMBS_iPhone_Package_Location
		fun_upload $SMBS_iPad_Package_FileName $SMBS_iPad_Package_Location
		fun_remote_shell "cd $SMBS_Android_Package_Location && tar xf $SMBS_Android_Package_FileName && rm -f $SMBS_Android_Package_FileName"
		fun_remote_shell "cd $SMBS_iPhone_Package_Location && tar xf $SMBS_iPhone_Package_FileName && rm -f $SMBS_iPhone_Package_FileName"
		fun_remote_shell "cd $SMBS_iPad_Package_Location && tar xf $SMBS_iPad_Package_FileName && rm -f $SMBS_iPad_Package_FileName"
	else
		echo "选择了生产代码，不提交生产包！"
	fi
}
