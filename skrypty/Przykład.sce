exec("BairstowMethod.sce");

//Definiowanie wielomianu
Input = poly([1 2 3 4 5 6],'x','c');

//Tolerancja błędu (0-1)
tolerance = 0.01;

//Wywołanie funkcji 
 [X, t] = BairstowMethod(Input, tolerance);

 //Wyświetlenie informacji w konsoli
 mprintf ("Czas obliczeń: %fms \n",t);
 mprintf ("Tolerancja Błędu: %f \n",tolerance);
 mprintf ("Wielomian: ");
 disp(Input);
 mprintf("Miejsca zerowe: \n");
printRoots(X);