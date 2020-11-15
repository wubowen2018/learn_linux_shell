# ------------导包------------
# 配置
source ./release_config/config.sh
# 版本控制工具
source ./release_utils/edition_utils.sh
# 发布工具
source ./release_utils/release_utils.sh
# 系统工具
source ./release_utils/system_utils.sh

# ------------发布------------
# 初始化
fun_init_release_config
# 检查打包环境
fun_check_release_device
# 说明
fun_print_readme
# 服务器时间检查修改
fun_check_release_time
# 发布用户状态核查
fun_check_release_user
# 选择代码版本
fun_choose_release_version
# 选择发布内容
fun_choose_compile_style
# 选择发布环境
fun_choose_release_target
# 选择后台环境
fun_choose_service_address
# 打印发布信息
fun_confirm_release_info
# 执行发布
fun_do_release
