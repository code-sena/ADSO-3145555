using CafetinSena.Domain.Entities;

public class DetallePedido
{
    public int Id { get; set; }

    public int PedidoId { get; set; } // Clave foránea al pedido
    public Pedido Pedido { get; set; }
    public int ProductoId { get; set; } // Clave foránea al producto
    public Producto Producto { get; set; }
    public int Cantidad { get; set; } 
    public decimal PrecioUnitario { get; set; }
    public decimal Subtotal => Cantidad * PrecioUnitario; // Calcula el subtotal para este detalle

}
