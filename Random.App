using System;

namespace TahminOyunu
{
    class Program
    {
        static void Main(string[] args)
        {
            Random random = new Random();
            int rastgeleSayi = random.Next(1, 6);
            int tahmin = 0;

            Console.WriteLine("1 ile 5 arasında bir sayı tahmin edin.");

            while (tahmin != rastgeleSayi)
            {
                string girilen = Console.ReadLine();

                if (!int.TryParse(girilen, out tahmin))
                {
                    Console.WriteLine("Geçersiz bir sayı girdiniz. Lütfen tekrar deneyin.");
                    continue;
                }

                if (tahmin < 1 || tahmin > 5)
                {
                    Console.WriteLine("Lütfen 1 ile 5 arasında bir sayı girin.");
                    continue;
                }

                if (tahmin < rastgeleSayi)
                {
                    Console.WriteLine("Daha yüksek bir sayı tahmin edin.");
                }
                else if (tahmin > rastgeleSayi)
                {
                    Console.WriteLine("Daha düşük bir sayı tahmin edin.");
                }
                else
                {
                    Console.WriteLine("Tebrikler, doğru sayıyı tahmin ettiniz!");
                }
            }

            Console.ReadLine();
        }
    }
}
