#!/bin/bash
branch=$1
tag=$2
#是否开启debug信息
Debug=true
#debug信息打印格式定义
function logdebug(){
	if [[ $Debug ]]; then
		echo "`date`"'[Debug]'$*
	fi
}
#info信息控制
function loginfo(){
	echo "`date`"'[info]'$*
}
#error控制信息
function logerror(){
	echo "`date`"'[error]'$*
}

function paramvali(){
	#branch参数非空验证
	if [[ -n $branch ]]; then
		logdebug "分支名称:"$branch
	else
		logerror "分支名称缺失"
		loginfo "按如下格式执行更新脚本"
		loginfo "*.sh branchname tagname"
		exit
	fi
	#branch参数非空验证
	if [[ -n $tag ]]; then
		logdebug "标签名称:"$tag
	else
		logerror "标签名称缺失"
		loginfo "按如下格式执行更新脚本"
		loginfo "*.sh branchname tagname"
		exit
	fi
}
#branch 检出
function branchcheckout(){
	git checkout $branch
	if [[ 0 != $? ]]; then
		logerror "无效分支或检出失败"$branch
		git branch -a
		exit
	else
		loginfo ${branch}"分支检出成功"
	fi
}

#branch 检出tag
function tagcheckout(){
	git checkout $tag
	if [[ 0 != $? ]]; then
		logerror "无效Tag或检出失败"$tag
		git tag -l
		exit
	else
		loginfo ${tag}"Tag检出成功"
	fi
}
#branch 更新
function branchpull(){
	git pull 
	if [[ 0 != $? ]]; then
		logerror "更新失败"$branch
		exit
	else
		loginfo ${branch}"更新成功"
	fi
}

#容器启动
function startcontainer(){
	#sudo docker-compose restart
	sudo docker-compose up -d
	sudo docker-compose restart
	if [[ 0 = $? ]]; then
		loginfo "容器启动成功"
	else
		logerror "容器启动失败"
		exit
	fi
}

#执行部署
function deploy(){
	#执行参数校验
	paramvali
	#切换分支
	branchcheckout
	#代码库更新
	branchpull
	#tag检出
	tagcheckout
	#容器启动
	startcontainer
	echo "分支:${branch}Tag:${tag}部署完成"
}

#执行更新
deploy