#include <stdio.h>
#include <time.h>
#include <stdlib.h>
extern void set_bit(unsigned char* value,unsigned char bit);
extern unsigned char get_bit(unsigned char value,unsigned char bit);
void update_temp(int* temp);
void update_flags(int* temps,int* last_temps,unsigned char* flags);
void imprimir(int* temps,unsigned char* flags,char** banderasC);

int main(){
    srand(time(NULL));
    int opc=0;
    unsigned char banderas[ 2 ]={0};
    int tem_sensores[ 2 ]={25,25};
    int tem_ant[ 2 ]={25,25};
    char* banderasC[7]={"-","<","<<","<<<",">",">>",">>>"};
    do{
        imprimir(tem_sensores,banderas,banderasC);
        printf("\n[1] Actualizar");
        printf("\n[2] Salir");
        printf("\nSeleccionar opcion");
        scanf("%d",&opc);
        switch(opc){
            case 1:
                update_temp(tem_sensores);
                update_flags(tem_sensores,tem_ant,banderas);
            break;
            case 2:
                printf("\nSaliendo del programa");
            break;
        }
    }while(opc!=2);


}

void update_temp(int* temp){
    temp[0]+= (rand() % 11) - 5;
    temp[1]+= (rand() % 11) - 5;
    return;

}

void update_flags(int* temps,int* last_temps,unsigned char* flags){
    int diferencia=0;
    for(int i=0;i<2;i++){
        flags[i]=0;
        diferencia=temps[i]-last_temps[i];
        if(diferencia==0){
            set_bit(&flags[i],0);
        }
        if(diferencia==-1||diferencia==1){
            set_bit(&flags[i],1);
        }
        if(diferencia==-2||diferencia==2){
            set_bit(&flags[i],2);
        }
        if(diferencia>2||diferencia<-2){
            set_bit(&flags[i],3);
        }
        if(diferencia<0){
            set_bit(&flags[i],4);
        }
        if(diferencia>0){
            set_bit(&flags[i],5);
        }
        last_temps[i] = temps[i];
    }
}

void imprimir(int* temps,unsigned char* flags,char** banderasC){
    int indice=0;
    for(int i=0;i<2;i++){
        if(get_bit(flags[i],0)){
            indice=0;
        }
        if(get_bit(flags[i],1)&&get_bit(flags[i],4)){
            indice=1;
        }
        if(get_bit(flags[i],2)&&get_bit(flags[i],4)){
            indice=2;
        }
        if(get_bit(flags[i],3)&&get_bit(flags[i],4)){
            indice=3;
        }
        if(get_bit(flags[i],1)&&get_bit(flags[i],5)){
            indice=4;
        }
        if(get_bit(flags[i],2)&&get_bit(flags[i],5)){
            indice=5;
        }
        if(get_bit(flags[i],3)&&get_bit(flags[i],5)){
            indice=6;
        }
        printf("\nSENSOR %d: ~%d °C %s",i+1,temps[i],banderasC[indice]);
    }
    printf("\n");
    return ;
}