#!/bin/bash
# author:菜鸟教程
# url:www.runoob.com
#GITHUB_WORKSPACE=/home/jwwwb/test
PDF_PATH=$GITHUB_WORKSPACE/PDFs
read_dir(){
    for file in `ls $GITHUB_WORKSPACE/$1`       #注意此处这是两个反引号，表示运行系统命令
    do
        if [ $file != PDFs ]
        then
            if [ -f $GITHUB_WORKSPACE/$1/$file ]  #注意此处之间一定要加上空格，否则会报错
            then
                #echo $GITHUB_WORKSPACE/$1/$file   #在此处处理文件即可
                #cp -r $GITHUB_WORKSPACE/$1/$file $PDF_PATH/$1/$file
                if [[ $file =~ '.md' ]]
                then
                    if [ ! -d $PDF_PATH/$1 ]
                    then
                        mkdir -p $PDF_PATH/$1
                    fi
                    echo "||||||||NOW CONVERTING"$1/$file"|||||||||||"
                    pandoc $GITHUB_WORKSPACE/$1/$file -o $PDF_PATH/$1/${file//'.md'/'.pdf'} --pdf-engine=xelatex -V mainfont='PingFang SC' --template=$GITHUB_WORKSPACE/scripts/template.tex
                fi
            else
                #mkdir -p $PDF_PATH/$1/$file
                read_dir $1/$file
            fi
        fi
    done
}   
#读取第一个参数
rm -rf $PDF_PATH
mkdir -p $PDF_PATH
read_dir /

