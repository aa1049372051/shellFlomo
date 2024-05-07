# SHELLOMO

A shell app for [flomo](https://flomoapp.com/register2/?Mzk4Nw)  
flomo 命令行工具

## 使用指南

```sh
$ git clone git@github.com:sfyumi/shellomo.git
$ cd shellomo
$ FLOMO_PATH=`pwd`/flomo.sh
$ cd ~
$ echo 'alias flomo="'$FLOMO_PATH'"' >> .bash_profile
$ source .bash_profile
# if you use zshell, write alias to .zshrc instead
$ flomo --api https://flomoapp.com/iwh/Mg/yourapisecretskey/
$ flomo -m "Hello shellomo"
send "Hello shellomo" to flomo
$ flomo -t inbox -m "Hello shellomo"
send "Hello shellomo #inbox" to flomo
```


## 没有vip就用flomo-novip.sh
登录flomoapp.com官网F12打开控制台,找到网络，找到头部有Authorization:的请求,如下
![image](https://github.com/aa1049372051/aa1049372051.github.io/assets/13846404/56a6e9dc-b0ac-4599-8f74-0878ee09eee2)
复制红框中的内容，执行如下脚本
```sh
$ git clone git@github.com:sfyumi/shellomo.git
$ cd shellomo
$ FLOMO_PATH=`pwd`/flomo-novip.sh
$ cd ~
$ echo 'alias flomo="'$FLOMO_PATH'"' >> .bash_profile
$ source .bash_profile
# if you use zshell, write alias to .zshrc instead
$ flomo --key 6350885|UwSf25ak4tHIVnSmQqJ81yjCWbxxxxxxxxx
$ flomo -m "Hello shellomo"
send "Hello shellomo" to flomo
$ flomo -t inbox -m "Hello shellomo"
send "Hello shellomo #inbox" to flomo
```

