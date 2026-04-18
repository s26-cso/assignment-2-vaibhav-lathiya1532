#include<stdio.h>
#include<string.h>
#include<dlfcn.h>
int main(){
    char op[30];
    int a,b;
    while(scanf("%s %d %d",op,&a,&b)==3){
        char libname[50];   
        strcpy(libname,"./lib");
        strcat(libname,op);
        strcat(libname,".so");

        void* handle=dlopen(libname,RTLD_LAZY);
        int (*fun)(int,int);
        fun=(int(*)(int,int))dlsym(handle,op);
        int ans=fun(a,b);
        printf("%d\n",ans);
        dlclose(handle);
    }
    return 0;
}
