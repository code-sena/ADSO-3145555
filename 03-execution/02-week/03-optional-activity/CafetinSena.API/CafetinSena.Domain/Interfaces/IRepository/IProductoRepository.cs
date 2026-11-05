using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CafetinSena.Domain.Entities;

namespace CafetinSena.Domain.Interfaces
{
    public interface IProductoRepository
    {
        Task<IEnumerable<Producto>> obtenerTodosLosProductos();
        Task<Producto> obtenerPorId(int id);
        Task guardarProducto(Producto producto);
        Task eliminarProducto(int id);
    }
}
