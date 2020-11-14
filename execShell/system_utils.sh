# 通过read单步调试
function fun_debug() {
	#echo $1 && read Step
	Debug="false"
}

# 打印日志
function fun_log() {
	#echo $1
	Log="false"
}


# 当前会话中存值
function fun_put() {
	eval "$1=\"$2\""
}

# 当前会话中取值
function fun_get() {
	eval "echo \$$1"
}

# 禁用ctrl+c
function fun_ctrl_c_disable {
	stty intr undef
}

# 启用ctrl+c
function fun_ctrl_c_enable {
	stty intr ^c
}

# 修改服务器时间
function fun_server_date_set {
	fun_print_line
	echo "请输入当前自然日期，格式如：2018-01-01"
	fun_print_line
	read Input
	date -s $Input > log.txt

	fun_print_line
	echo "请输入当前自然时间，格式如：18:18:18"
	fun_print_line
	read Input
	date -s $Input > log.txt

	echo "当前服务器时间：" `date "+%Y-%m-%d %H:%M:%S"`
}

# 释放发布锁
function fun_release_lock {
	rm -fr $Release_Lock_File
}

# 创建操作锁
function fun_create_lock {
	touch $Release_Lock_File
}

# 完全退出（释放锁，释放ctrl c限制）
function fun_exit {
	fun_release_lock
	fun_ctrl_c_enable
	exit
}

# 检查目录是否存在，存在返回1，不存在返回0
function fun_check_directory {
	if [ ! -d "$1" ]; then
		return 0
	else
		return 1
	fi
}

# 检查文件是否存在，存在返回1，不存在返回0
function fun_check_file {
	if [ ! -f "$1" ]; then
		return 0
	else
		return 1
	fi
}

# 检查目录并且提示创建
function fun_check_and_create_directory {
	if fun_check_directory $1 >/dev/null 2>&1; then
		echo "$1目录不存在, 是否创建?[y/n]"
		read choice
		if [ "$choice" = "y" ]; then
			mkdir $1
		else
			fun_exit
		fi    
	fi
}

# 检查文件并且提示创建
function fun_check_and_create_file {
	if fun_check_file $1 >/dev/null 2>&1; then
		echo "$1文件不存在, 是否创建?[y/n]"
		read choice
		if [ "$choice" = "y" ]; then
			touch $1
		else
			fun_exit
		fi    
	fi
}

# 输入项的通用检查，通过参数重载
function fun_check_input() {
	if [ "$1" == "quit" ]; then
		if [ "$2" == "q" ]; then
			fun_exit
		fi
	fi
}

# 打印线
function fun_print_line() {
	echo "---------------------------------------------------------"
}
