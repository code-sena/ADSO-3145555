using System;

public class Pedido
{
	public int Id { get; set; }
    public  DateTime Fecha { get; set; } // Cuando se hizo
    public string Cliente { get; set; }
    public decimal Total { get; set; }
    public List<DetallePedido> Detalles { get; set; } = new List<DetallePedido>();// Lista de productos en el pedido

}
