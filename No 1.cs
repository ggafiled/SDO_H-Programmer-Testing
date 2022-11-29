using System;
using System.IO;
					
public class Program
{
	public static void Main()
	{
		int tree_layer = Convert.ToInt32(Console.ReadLine());
		int asterix_size = 1;
		int space = tree_layer;
		int tmp_asterix_size = 1;
		int tmp_space = space;
		
		for(int i = 0; i < tree_layer; i++){
		   
		    
		    int represent = ((i+1)%10);
		    		
			for(int j = 0; j < space; j++)
			Console.Write(" ");
			for(int j = 0; j < asterix_size; j++)
			Console.Write(represent.ToString() + (i+1 % 2 != 0 ? " ": "  "));
			
            space--;
			asterix_size++;
			
			Console.WriteLine();
		}
	}
}