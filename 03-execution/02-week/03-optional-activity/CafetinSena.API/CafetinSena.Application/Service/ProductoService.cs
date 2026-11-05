using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CafetinSena.Application.DTOs.DtoProducto;
using CafetinSena.Application.IService;
using CafetinSena.Application.Mappers;
using CafetinSena.Domain.Interfaces;


namespace CafetinSena.Application.Service
{
    public class ProductoService : IProductoService
    {
        private readonly IProductoRepository repo;


        public ProductoService(IProductoRepository repo) // aca estoy haciendo la inyeccion de dependencias 
        {
            this.repo = repo;
        }


        public async Task<IEnumerable<ProductoDto>> listarProductos()
        {
            var productos = await repo.obtenerTodosLosProductos();
            return productos.Select(p => ProductoMapper.ToDTO(p));

        }

        public async Task<ProductoDto> obtenerPorId(int id)
        {
            var productos = await repo.obtenerPorId(id);
            return ProductoMapper.ToDTO(productos);

        }

        public async Task<ProductoDto> crearProducto(ProductoCreateDto productoCreateDto)
        {
            var producto = ProductoMapper.ToEntity(productoCreateDto);
            await repo.guardarProducto(producto);
            return ProductoMapper.ToDTO(producto);
        }



    }
}