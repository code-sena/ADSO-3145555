using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CafetinSena.Application.DTOs.DtoProducto;
using CafetinSena.Domain.Entities;


namespace CafetinSena.Application.Mappers
{
    public class ProductoMapper
    {
        public static Producto ToEntity(ProductoCreateDto dto)
        {
            return new Producto
            {
                Nombre = dto.Nombre,
                Precio = dto.Precio,
                Stock = dto.Stock,
                FechaCreacion = DateTime.UtcNow,
                Eliminado = false
            };
        }

        public static ProductoDto ToDTO(Producto producto)
        {
            return new ProductoDto
            {
                Id = producto.Id,
                Nombre = producto.Nombre,
                Precio = producto.Precio,
                Stock = producto.Stock
            };
        }
    }
}
