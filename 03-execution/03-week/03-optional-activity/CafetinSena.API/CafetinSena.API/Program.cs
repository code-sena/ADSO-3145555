using CafetinSena.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using CafetinSena.Application.IService;
using CafetinSena.Application.Service;
using CafetinSena.Domain.Interfaces;
using CafetinSena.Infrastructure.Repositories;
using CafetinSena.Domain.Interfaces.IRepository;


namespace CafetinSena.API
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // ----------------------------
            // Agregar servicios
            // ----------------------------
            builder.Services.AddControllers();

            // Configurar DbContext para PostgreSQL
            builder.Services.AddDbContext<CafetinDbContext>(options =>
                options.UseNpgsql(
                    builder.Configuration.GetConnectionString("DefaultConnection"),
                    b => b.MigrationsAssembly("CafetinSena.Infrastructure")
                ));

            // Swagger para .NET 8
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();
            builder.Services.AddScoped<IProductoService, ProductoService>();
            builder.Services.AddScoped<IProductoRepository, ProductoRepository>();
            builder.Services.AddScoped<IPedidoRepository , PedidoRepository>();
            builder.Services.AddScoped<IPedidoService, PedidoService>();

            var app = builder.Build();

            // Middleware
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseHttpsRedirection();
            app.UseAuthorization();
            app.MapControllers();

            app.Run();
        }
    }
}