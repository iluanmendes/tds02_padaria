using backPadaria.Model;

namespace backPadaria
{
    internal class Program
    {
        static void Main(string[] args)
        {
            string nome;


            try
            {
                Console.WriteLine("Digite o nome do cliente");
                nome = Console.ReadLine();

                Cliente cliente1 = new Cliente(
                nome: nome,
                cpf: "1234",
                telefone: "1111",
                endereco: "Rua rua",
                pontos: 123
                );
            }catch(Exception err)
            {

                Console.WriteLine(err.Message);
            }
            

            // Bom dia

          
        }
    }
}
