#!/bin/sh

#### 搭建 moon 服务器

### 注意：执行以下脚本，需要使用 bash xxx.sh，而不是 sh xxx.sh


# 如果存在则删除
if [ ! -d "/var/lib/zerotier-one" ];then
    curl -s https://install.zerotier.com/ | sudo bash
    echo "成功下载 zerotier-one"
fi

network_id="加入的network_id"

network_list=$(zerotier-cli listnetworks)

# 判断是否已加入某个网络，如果没有则加入
if [[ ${network_list} == *${network_id}* ]];then
    echo "已加入网络：${network_id}"
    else
    zerotier-cli join ${network_id}
fi

#加入创建好的局域网
zerotier-cli join ${network_id}

#生成并给配置文件赋权
chmod 777 /var/lib/zerotier-one

# 进入 zerotier-one 所在目录
cd /var/lib/zerotier-one

# 生成配置文件
zerotier-idtool initmoon identity.public > moon.json

# 获取公网 ip
public_ip=$(curl ip.sb)

# 替换公网 ip
sed -i  "s/stableEndpoints\": \[\]/stableEndpoints\": \[\"${public_ip}:9993\"\]/g" moon.json

# 目标目录目录
target_direct='moons.d'

# 如果存在则删除
if [ -d ${target_direct} ];then
  rm -fr ${target_direct}
fi

# 创建目录
mkdir ${target_direct}

# 生成 moon 文件
zerotier-idtool genmoon moon.json

# 生成的 moon 文件前缀
prefix="000000"

# 获取 node_id，因为生成的 moon 文件，其名称构成是 "000000" + node_id + ".moon"
node_id=$(zerotier-cli info | cut -d ' ' -f3)

# 移动 moon 文件至 moons.d 目录
mv "${prefix}${node_id}.moon" ${target_direct}

echo "Moon 服务器搭建成功"
