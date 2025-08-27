#pragma once

#include <vector>
#include <sys/stat.h>

#ifndef INC_Tiles
#include "Tiles.h"
#endif // !INC_Tiles

#ifndef INC_MaterialInstance
#include "MaterialInstance.h"
#endif // !INC_MaterialInstance

#include <iostream>
#include <fstream>

#define INC_Chunk

#define CHUNK_W 128
#define CHUNK_H 128

#ifndef INC_Biome
#include "Biome.h"
#endif // !INC_Biome

#include "RigidBody.h"

typedef struct {
    Uint32 index;
    Uint32 color;
    int32_t temperature;
} MaterialInstanceData;

class Chunk {
    const char* fname;
public:
    int x;
    int y;
    bool hasMeta = false;
    // in order for a chunk to execute phase generationPhase+1, all surrounding chunks must be at least generationPhase
    int generationPhase = 0;
    bool pleaseDelete = false;

    Chunk(int x, int y, char* worldName);
    Chunk() : Chunk(0, 0, (char*)"chunks") {};
    ~Chunk();

    void loadMeta();

    static MaterialInstanceData* readBuf;
    void read();
    void write(MaterialInstance* tiles, MaterialInstance* layer2, Uint32* background);
    bool hasFile();

    bool hasTileCache = false;
    MaterialInstance* tiles = nullptr;
    MaterialInstance* layer2 = nullptr;
    Uint32* background = nullptr;
    Biome** biomes = nullptr;

    std::vector<b2PolygonShape> polys = {};
    RigidBody* rb = nullptr;
};
