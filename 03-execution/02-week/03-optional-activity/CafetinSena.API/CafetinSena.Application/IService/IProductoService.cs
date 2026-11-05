using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CafetinSena.Application.DTOs.DtoProducto;
using CafetinSena.Domain.Entities;

namespace CafetinSena.Application.IService
{
    public interface IProductoService
    {
        Task<IEnumerable<ProductoDto>> listarProductos();
        Task<ProductoDto> obtenerPorId(int id);
        Task<ProductoDto> crearProducto(ProductoCreateDto productoCreateDto);
    }
}
