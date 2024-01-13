# Использование базового образа SDK для сборки и публикации приложения
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["MyCapRoverApp.csproj", "./"]
RUN dotnet restore "MyCapRoverApp.csproj"
COPY . .
RUN dotnet publish "MyCapRoverApp.csproj" -c Release -o /app/publish

# Использование образа ASP.NET Runtime для запуска приложения
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "MyCapRoverApp.dll"]