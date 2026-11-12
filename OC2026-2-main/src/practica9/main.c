#include<stdio.h>
#define MAX 5

extern void _imprimir(char*,char*);
extern int _minimo(int*,int);
extern int _maximo(int*,int);
extern int _sumatoria(int*,int);

int main(void)
{
    int arreglo[MAX]={};
    for(int i=0;i<MAX;i++){
        printf("\nCaptura el numero de la posicion [%d]: ",i);
        scanf("%d",&arreglo[i]);
    }
    printf("Arreglo: ");
    for(int i=0;i<MAX;i++){
        printf(" %d",arreglo[i]);
    }
    printf("\nValor maximo: %d",_maximo(arreglo,MAX));
    printf("\nValor minimo: %d",_minimo(arreglo,MAX));
    printf("\nSumatoria de los valores: %d",_sumatoria(arreglo,MAX));
    return 0;
}

int minimoC(int* arreglo,int len){
    int minimo=arreglo[0];
    for(int i=0;i<len;i++){
        if(arreglo[i]<minimo)
            minimo=arreglo[i];
    }
    return minimo;
}

int maximoC(int* arreglo,int len){
    int maximo=arreglo[0];
    int cont=0;
    while(cont<len){
        if(arreglo[cont]>maximo)
            maximo=arreglo[cont];
        cont++;
    }
    return maximo;
}

int suamtoriaC(int* arreglo,int len){
    int cont=0;
    int resultado=0;
    while(cont<len){
        resultado+=arreglo[cont++];
    }
    return resultado;
}