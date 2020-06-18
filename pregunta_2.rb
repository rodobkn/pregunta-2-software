class EncriptarOriginal      

    attr_reader :abecedario

    def initialize()   #Este sería el "init" en ruby
        
        @abecedario = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
                    "m", "n","o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"] #lenght = 26
		
	end

    def rot_n(string_encriptar , numero_n)    

        nuevo_string = ""
        
        string_encriptar.split("").each do |letra|
            
            contador = 0

            if letra == " "

                nuevo_string << " "
            
            else

                for indice in(0..25)

                    if letra == @abecedario[indice]

                        indice_capturado = indice
                        break
                    end

                end

                nuevo_indice = indice_capturado + numero_n

                while nuevo_indice > 25

                    nuevo_indice = nuevo_indice - 26

                end
                

                nuevo_string << @abecedario[nuevo_indice]
            
            end

        end

        
           
        return nuevo_string
		
    end
    
    def simple_transpose(string_encriptar, numero_n)

        lista_del_string = string_encriptar.split("")
        tamano_lista = lista_del_string.length


        contador = 0
        string_encriptar.split("").each do |letra|

            nuevo_indice = contador + numero_n

            while nuevo_indice > (tamano_lista - 1)

                nuevo_indice = nuevo_indice - tamano_lista

            end

            lista_del_string[nuevo_indice] = letra

            contador += 1

        end

        nuevo_string = ""

        lista_del_string.each do |letra|

            nuevo_string << letra
        end

        
        return nuevo_string

    end

    def desencriptar_rot_n(string_desencriptar, numero_n)

        nuevo_string = ""
        
        string_desencriptar.split("").each do |letra|
            
            contador = 0

            if letra == " "

                nuevo_string << " "
            
            else

                for indice in(0..25)

                    if letra == @abecedario[indice]

                        indice_capturado = indice
                        break
                    end

                end

                nuevo_indice = indice_capturado - numero_n

                while nuevo_indice < 0

                    nuevo_indice = nuevo_indice + 26

                end
                
                nuevo_string << @abecedario[nuevo_indice]
            
            end

        end

        
           
        return nuevo_string


    
    end

    def desencriptar_simple_transpose(string_desencriptar, numero_n)


        lista_del_string = string_desencriptar.split("")
        tamano_lista = lista_del_string.length


        contador = 0
        string_desencriptar.split("").each do |letra|

            nuevo_indice = contador - numero_n

            while nuevo_indice < 0

                nuevo_indice = nuevo_indice + tamano_lista

            end

            lista_del_string[nuevo_indice] = letra

            contador += 1

        end

        nuevo_string = ""

        lista_del_string.each do |letra|

            nuevo_string << letra
        end

        
        return nuevo_string        



    
    end



end                 



class DecoratorEncriptacion

    def initialize(decorator)
        
        @decorator = decorator
        @lista_numeros_algoritmo_encriptacion = []
        @lista_numeros_asignados = []
    end

    def abecedario       #Puesto que la clase decorada tiene un atributo abecedario
 
        @decorator.abecedario

    end

    def encrypt(string_encriptar)

        string_real = string_encriptar
        numero_probabilidad = 0

        while numero_probabilidad < 0.8

            numero_algoritmo_encriptacion = rand(1..2)

            @lista_numeros_algoritmo_encriptacion.push(numero_algoritmo_encriptacion)

            if numero_algoritmo_encriptacion == 1

                n_asignado = rand(1..10)
                @lista_numeros_asignados.push(n_asignado)

                string_real = @decorator.rot_n(string_real, n_asignado)

                numero_probabilidad = rand()
            
            else

                n_asignado = rand(1..10)
                @lista_numeros_asignados.push(n_asignado)

                string_real = @decorator.simple_transpose(string_real, n_asignado)

                numero_probabilidad = rand()
            
            end
        
        end

        return string_real
    
    end


    def decrypt(string_desencriptar)
        
        string_real = string_desencriptar
        contador = 0
        lista_al_reves_de_numeros_algortimo = @lista_numeros_algoritmo_encriptacion.reverse
        lista_al_reves_de_numeros_asignados = @lista_numeros_asignados.reverse

        lista_al_reves_de_numeros_algortimo.each do |numero_de_algoritmo|

            if numero_de_algoritmo == 1

                numero_asignado = lista_al_reves_de_numeros_asignados[contador]

                string_real = @decorator.desencriptar_rot_n(string_real, numero_asignado)
            
            else
                numero_asignado = lista_al_reves_de_numeros_asignados[contador]

                string_real = @decorator.desencriptar_simple_transpose(string_real, numero_asignado)

            end

            contador += 1
        
        end

        return string_real

        
    end



end



def get_random_cipher

    objeto = EncriptarOriginal.new()
    objeto = DecoratorEncriptacion.new(objeto)

    return objeto

end

objeto_retornado = get_random_cipher

puts "Ingrese una frase que desee encriptar: "
string_recibido = gets.chomp

string_encriptado = objeto_retornado.encrypt(string_recibido)
puts "A continuacion se mostrara tu frase encriptada"
puts string_encriptado
string_desencriptado = objeto_retornado.decrypt(string_encriptado)
puts "A continuacion se mostrara tu frase desencriptada"
puts string_desencriptado
