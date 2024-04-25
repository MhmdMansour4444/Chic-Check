<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('item_compatibility', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('first_clothes_id');
            $table->unsignedBigInteger('second_clothes_id');
            $table->float('match_percentage')->nullable();
            $table->timestamps();
            $table->foreign('first_clothes_id')->references('id')->on('clothes')->onUpdate('cascade')->onDelete('cascade');
            $table->foreign('second_clothes_id')->references('id')->on('clothes')->onUpdate('cascade')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('item_compatibility');
    }
};
