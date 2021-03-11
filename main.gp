\\--------------Approches----------------

\\dans un premier temps, on remarque que l'on a affaire à un chiffrement
\\de Rabin. Ce dernier est résistant aux attaques CPA mais pas CCA.
\\En l'absence d'un oracle permettant d'exécuter une attaque CCA, on se
\\résoud à factoriser n, en se doutant que ce dernier doit présenter une
\\faiblesse malgré sa taille crypto.

\\PREMIERE HYPOTHESE
\\p - q est faible. En conséquence, il suffirait de tester la division de n par
\\p premier en partant de sqrt(n). On peut utiliser nextprime() pour cela.
\\Dans cette même hypothèse, on peut supposer que p et q soient justes 
\\impairs. On teste donc les éléments impairs en partant de sqrt(n).
\\Il y en a une grande quantité, c'est pourquoi, avec Marc et Julien, nous nous
\\sommes répartis afin de faire les tests : on test par pas de 6 avec chacun
\\un décalage initial différent. Cette hypothèse n'a rien donné.

\\SECONDE HYPOTHESE
\\p et q sont B-friables avec B peu grand. Il suffirait d'effectuer alors 
\\l'algorithme du Rho de Pollard. Cette hypothèse s'est avérée juste.
\\Afin de réduire le temps nécessaire pour faire les calculs, on a ici
\\précalculé p avec le Rho de Pollard

\\Conclusion
\\Il est capital de choisir judicieusement p et q afin d'éviter des attaques
\\comme celles présentées ci dessus. Néanmoins, cela ne réduit en rien la 
\\faiblesse du protocole de Rabin contre des attaques CCA-2



encode(m)=fromdigits(Vec(Vecsmall(m)),128);
[n,c] = readvec("input.txt");

decode(c) ={
	tmp = digits(c,128);
	Strchr(vector(#tmp, i, if(tmp[i] == 0, 32, tmp[i])));
};

Rho(n) ={
	i = 2;
	a = 2;
	while(1,
		a = a^i%n;
		d = gcd(a-1, n);
		if(d>1,break);
		i++;
	);
	d;
};

dechiffre(c,p,q)=
{
	tmp = Mod(c[1],n);
	
	cp = tmp^((p+1)/4);
	cq = tmp^((q+1)/4);
	b = bezout(p,q);
	yp = b[1];
	yq = b[2];
	r3 = (yp*p*cq-yq*q*cp);
	r4 = n-r3;

	print(decode(lift(r4)));

};

\\p =Rho(n);
p = 4324639416903731531948697571405200993976675749101812850062095737236087825691184178808528107554284380991472923934171832835074571890078743135937622429751759763816233797098008503721658082348268317252023490434742493396713016612928445966955577193055835511255768698424708193826753050056446346607276852212501898583967;
q = n/p;
dechiffre(c,p,q);
