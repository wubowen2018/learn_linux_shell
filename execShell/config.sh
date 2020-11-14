# 初始化版本发布人员
function fun_init_release_user {
	fun_put heyupeng "贺宇鹏"
	fun_put heyupeng_status "ok"

	fun_put xufeng "徐峰"
	fun_put xufeng_status "ok"

	fun_put sunjiajie "孙佳杰"
	fun_put sunjiajie_status "ok"

	fun_put jiangjiahang "蒋佳航"
	fun_put jiangjiahang_status "ok"
}

# 初始化服务器环境信息
function fun_init_server_user {
	# 版本发布环境
	fun_put deploy_server_username "ewpapp"
	fun_put deploy_server_ip "10.20.151.38"
	# 开发联调环境24
	fun_put dev24_server_username "ewpapp"
	fun_put dev24_server_ip "10.20.152.24"
	# 开发联调环境26
	fun_put dev26_server_username "ewpapp"
	fun_put dev26_server_ip "10.20.152.26"
	# 系统测试环境
	fun_put sit_server_username "ewpapp"
	fun_put sit_server_ip "10.20.182.33"
	# 投产演练环境
	fun_put trl_server_username "ewpapp"
	fun_put trl_server_ip "10.20.151.38"

	# ------------SIT后台地址配置------------
	fun_put sit_pbankhost_address             "10.20.113.94:9081/pwweb/"
	fun_put sit_enbankhost_address            "10.20.113.97:9081/srcbephone/"
	fun_put sit_qrcodehost_address            "10.20.151.238:9087/mpay-web/"
	fun_put sit_maphost_address               "10.20.43.110:8080/srcbGIS/"
	fun_put sit_infohost_address              "10.20.109.103:9080/Moblie.jhtml"

	# ------------挡版后台地址配置------------
	fun_put simulator_pbankhost_address       "10.20.151.38:4003/sim/pwweb/"
	fun_put simulator_enbankhost_address      "10.20.151.38:4003/sim/srcbephone/"
	fun_put simulator_qrcodehost_address      "10.20.151.38:4003/sim/qrcode/"
	fun_put simulator_maphost_address         "10.20.43.110:8080/srcbGIS/"
	fun_put simulator_infohost_address        "10.20.109.103:9080/Moblie.jhtml"
}

# 初始化文件地址配置
function fun_init_app_locate {
	# 打包路径
	SMBS_Deploy_Location="/ewp/deploy/smbs/"
	# SVN地址
	Svn_Address="https://10.20.152.34:8443/svn/"
	
	# 代码路径
	# ------手机银行------
	# SIT代码下载路径
	SIT_Code_Location=$SMBS_Deploy_Location"release_svn/sit/"
	# PRO代码下载路径
	PRO_Code_Location=$SMBS_Deploy_Location"release_svn/pro/"
	# TRL代码下载路径
	TRL_Code_Location=$SMBS_Deploy_Location"release_svn/trl/"

	# SIT代码SVN路径
	SMBS_Server_SIT_App_Code_Svn_Location=$Svn_Address"手机银行与直销银行APP/02.（Src_Library）源码库/01.（Develop）开发/04.Server/01.验收阶段/smbs_mbank_emp3.2/mbank/"
	SMBS_Server_SIT_Framework_Code_Svn_Location=$Svn_Address"手机银行与直销银行APP/02.（Src_Library）源码库/01.（Develop）开发/04.Server/01.验收阶段/smbs_ewp_emp3.2/ewp/"
	# PRO代码SVN路径
	SMBS_Server_PRO_App_Code_Svn_Location=$Svn_Address"手机银行与直销银行APP/02.（Src_Library）源码库/01.（Develop）开发/04.Server/03.运行阶段/smbs_mbank_emp3.2/mbank/"
	SMBS_Server_PRO_Framework_Code_Svn_Location=$Svn_Address"手机银行与直销银行APP/02.（Src_Library）源码库/01.（Develop）开发/04.Server/03.运行阶段/smbs_ewp_emp3.2/ewp/"
	# TRL代码SVN路径
	SMBS_Server_TRL_App_Code_Svn_Location=$Svn_Address"手机银行与直销银行APP/02.（Src_Library）源码库/01.（Develop）开发/04.Server/02.试运行阶段/smbs_mbank_emp3.2/mbank/"
	SMBS_Server_TRL_Framework_Code_Svn_Location=$Svn_Address"手机银行与直销银行APP/02.（Src_Library）源码库/01.（Develop）开发/04.Server/02.试运行阶段/smbs_ewp_emp3.2/ewp/"
	
	# 手机银行系统路径
	SMBS_System_Install_Location="/ewp/apps/"
	# 手机银行系统备份路径
	SMBS_System_Backup_Location="/ewp/apps/backapp/"

	# 手机银行应用安装路径
	SMBS_APP_Install_Location="/ewp/apps/mbank/"
	# 手机银行应用资源路径
	SMBS_APP_Resource_Location=$SMBS_APP_Install_Location"public/www/"
	# 手机银行框架安装路径
	SMBS_Framework_Install_Location="/ewp/apps/ewp"
	# 手机银行应用配置文件路径
	SMBS_APP_Install_Conf=$SMBS_APP_Install_Location"config"
	
	# 手机银行应用安装包存放名称
	SMBS_Android_Package_FileName="TESTBL_APK.tar"
	SMBS_iPhone_Package_FileName="TESTBL_IPA_IPHONE.tar"
	SMBS_iPad_Package_FileName="TESTBL_IPA_IPAD.tar"

	# 手机银行应用安装包存放路径
	SMBS_Android_Package_Location=$SMBS_APP_Resource_Location"mobile/android/"
	SMBS_iPhone_Package_Location=$SMBS_APP_Resource_Location"mobile/iPhone/"
	SMBS_iPad_Package_Location=$SMBS_APP_Resource_Location"mobile/iPad/"

	# 手机银行应用打包机源码路径
	SMBS_APP_Src_Location=$SMBS_Deploy_Location"mbank/"
	# 手机银行应用打包机编译路径
	SMBS_APP_Ebin_Location=$SMBS_Deploy_Location"mbank/ebin/"
	# 手机银行框架打包机源码路径
	SMBS_Framework_Src_Location=$SMBS_Deploy_Location"ewp/"
	# 手机银行框架打包机编译路径
	SMBS_Framework_Ebin_Location=$SMBS_Deploy_Location"ewp/ebin/"
	# 手机银行应用配置打包文件路径
	SMBS_APP_File_Location=$SMBS_Deploy_Location"release_file/"
	# 手机银行客户端打包文件路径
	SMBS_APP_Client_Package_Location=$SMBS_Deploy_Location"release_client_package/"
}

# 初始化发布相关配置
function fun_init_app_config {
	set `date "+%Y-%m-%d_%H-%M-%S"`
	Package_Backup_Time=$1
	
	# 发布工作锁文件名称
	Release_Lock_File="/ewp/packaging/lockrelease.lock"
	# 发布机器IP
	Release_Server_IP="10.20.151.38"
	# 发布机器用户名
	Release_Server_User="ewpapp"
	# 发布脚本名称
	Release_Script_File_Name="release.sh"
}

# 初始化发布文字信息
function fun_init_msg {	
	# 默认提示信息
	Default_Tip_Message="M为默认项，选择默认项直接回车。"
}

# 初始化命令配置
function fun_init_cmd {
	# 手机银行应用配置命令
	SMBS_APP_Configure="./configure --with-debug --without-mysql"
	# 手机银行应用编译命令
	SMBS_APP_Clean_Compile="make clean"
	SMBS_APP_Compile="make"

	# 手机银行框架配置命令
	SMBS_Framework_Configure="./configure --with-debug --without-mysql"
	# 手机银行框架编译命令
	SMBS_Framework_Clean_Compile="make clean"
	SMBS_Framework_Compile="make"
	
	# 手机银行应用服务停止命令
	SMBS_Server_Stop="/ewp/apps/ewp/bin/ewp_ctrl stop > release.log"
	# 手机银行应用服务启动命令
	SMBS_Server_Start="/ewp/apps/ewp/bin/ewp_ctrl start > release.log"
	# 手机银行应用服务重启命令
	SMBS_Server_Restart="/ewp/apps/ewp/bin/ewp_ctrl restart > release.log"
	
	# 手机银行应用缓存文件备份命令
	SMBS_Server_Tmp_Backup="
		cd $SMBS_APP_Install_Location &&
		tar cf log_backup.tar log &&
		tar cf xml_backup.tar xml &&
		mv log_backup.tar xml_backup.tar $SMBS_System_Backup_Location &&
		cd $SMBS_APP_Resource_Location &&
		tar cf advert_backup.tar advert &&
		tar cf card_backup.tar card &&
		mv advert_backup.tar card_backup.tar $SMBS_System_Backup_Location"

	# 手机银行应用缓存文件还原命令
	SMBS_Server_Tmp_Restore="
		cd $SMBS_System_Backup_Location &&
		mv log_backup.tar xml_backup.tar $SMBS_APP_Install_Location &&
		mv advert_backup.tar card_backup.tar $SMBS_APP_Resource_Location &&
		cd $SMBS_APP_Install_Location &&
		tar xf log_backup.tar &&
		tar xf xml_backup.tar &&
		rm -f log_backup.tar xml_backup.tar &&
		cd $SMBS_APP_Resource_Location &&
		tar xf advert_backup.tar &&
		tar xf card_backup.tar &&
		rm -f advert_backup.tar card_backup.tar"

	# 更新手机银行应用包
	SMBS_App_Update="cd /ewp/apps/ && rm -rf mbank && tar xf mbank.tar && chmod -R 755 mbank && rm -rf mbank.tar"
	# 更新手机银行框架包
	SMBS_Framework_Update="cd /ewp/apps/ && rm -rf ewp && tar xf ewp.tar && chmod -R 755 ewp && rm -rf ewp.tar"
}

