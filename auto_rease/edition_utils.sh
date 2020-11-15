# 检查svn目录是否建立，如果没有，自动检出并更新；
# 如果有，直接更新
function fun_svn_up {
	if [ "$1" == "smbs" ]; then
		if [ "$2" == "mbank" ]; then
			fun_svn_up_smbs_app
		elif [ "$2" == "mbank&ewp" ]; then
			fun_svn_up_smbs_app
			fun_svn_up_smbs_framework
		else
			echo "代码未更新，退出！"
			fun_exit
		fi
		echo "手机银行代码更新完成!"
	elif [ "$1" == "dbpapp" ]; then
		fun_svn_up_dbpapp
		echo "直销银行代码更新完成!"
	else
		echo "代码未更新，退出！"
		fun_exit
	fi
}

# 更新手机银行应用svn
function fun_svn_up_smbs_app {
	fun_check_and_create_directory $SIT_Code_Location
	fun_check_and_create_directory $PRO_Code_Location
	fun_check_and_create_directory $TRL_Code_Location

	if [ "$Release_Code_Version" == "sit" ]; then
		if [ "`cd $SIT_Code_Location && svn up mbank`" = "Skipped 'mbank'" ]; then
			echo "执行检出sit应用代码。"
			cd $SIT_Code_Location && svn checkout $SMBS_Server_SIT_App_Code_Svn_Location mbank > release.log
			echo "检出sit应用代码完成。"
		else
			echo "执行更新sit应用代码。"
			svn up mbank
			echo "更新sit应用代码完成。"
		fi
	elif [ "$Release_Code_Version" == "pro" ]; then
		if [ "`cd $PRO_Code_Location && svn up mbank`" = "Skipped 'mbank'" ]; then
			echo "执行检出pro应用代码。"
			cd $PRO_Code_Location && svn checkout $SMBS_Server_PRO_App_Code_Svn_Location mbank > release.log
			echo "检出pro应用代码完成。"
		else
			echo "执行更新pro应用代码。"
			svn up mbank
			echo "更新pro应用代码完成。"
		fi
	elif [ "$Release_Code_Version" == "trl" ]; then
		if [ "`cd $TRL_Code_Location && svn up mbank`" = "Skipped 'mbank'" ]; then
			echo "执行检出trl应用代码。"
			cd $TRL_Code_Location && svn checkout $SMBS_Server_TRL_App_Code_Svn_Location mbank > release.log
			echo "检出trl应用代码完成。"
		else
			echo "执行更新trl应用代码。"
			svn up mbank
			echo "更新trl应用代码完成。"
		fi
	else
		fun_exit
	fi

	fun_print_line
}

# 更新手机银行框架svn
function fun_svn_up_smbs_framework {
	fun_check_and_create_directory $SIT_Code_Location
	fun_check_and_create_directory $PRO_Code_Location
	fun_check_and_create_directory $TRL_Code_Location

	if [ "$Release_Code_Version" == "sit" ]; then
		if [ "`cd $SIT_Code_Location && svn up ewp`" = "Skipped 'ewp'" ]; then
			echo "执行检出sit框架代码。"
			cd $SIT_Code_Location && svn checkout $SMBS_Server_SIT_Framework_Code_Svn_Location ewp > release.log
			echo "检出sit框架代码完成。"
		else
			echo "执行更新sit框架代码。"
			svn up ewp
			echo "更新sit框架代码完成。"
		fi
	elif [ "$Release_Code_Version" == "pro" ]; then
		if [ "`cd $PRO_Code_Location && svn up ewp`" = "Skipped 'ewp'" ]; then
			echo "执行检出pro框架代码。"
			cd $PRO_Code_Location && svn checkout $SMBS_Server_PRO_Framework_Code_Svn_Location ewp > release.log
			echo "检出pro框架代码完成。"
		else
			echo "执行更新pro框架代码。"
			svn up ewp
			echo "更新pro框架代码完成。"
		fi
	elif [ "$Release_Code_Version" == "trl" ]; then
		if [ "`cd $TRL_Code_Location && svn up ewp`" = "Skipped 'ewp'" ]; then
			echo "执行检出trl框架代码。"
			cd $TRL_Code_Location && svn checkout $SMBS_Server_TRL_Framework_Code_Svn_Location ewp > release.log
			echo "检出trl框架代码完成。"
		else
			echo "执行更新trl框架代码。"
			svn up ewp
			echo "更新trl框架代码完成。"
		fi
	else
		fun_exit
	fi
	
	fun_print_line
}

# 更新直销银行svn
function fun_svn_up_dbpapp {
	""
}

# 删除打包后的svn相关文件
function fun_delete_svn_tmp {
	find $1 -type d -name ".svn"|xargs rm -rf
}