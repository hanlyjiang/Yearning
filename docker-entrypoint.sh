#!/bin/sh

flag_file="/opt/install_flag"

if [ -f $flag_file ]; then
  echo "找到install标记文件"
  read -r install_flag <"$flag_file"
  installed=$(echo $install_flag | awk -F "=" '{print $2}')
  echo "是否已经安装？ $installed"
  if [ "false" = "$installed" ]; then
    echo "需要安装，开始安装... /opt/Yearning install"
    /opt/Yearning install
    if [ $? = 0 ];then
      echo "安装成功"
      echo "installed=true">$flag_file
    fi
  elif [ "true" = "$installed" ]; then
    echo "已经安装，直接运行..."
  fi
else
  echo "未找到/opt/install_flag文件，不执行安装"
fi

echo "开始运行 Yearning run"
exec /opt/Yearning run
