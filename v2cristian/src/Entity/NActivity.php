<?php

namespace App\Entity;

use App\Repository\NActivityRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=NActivityRepository::class)
 */
class NActivity
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $title;

    /**
     * @ORM\Column(type="string", length=1500)
     */
    private $description;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $place;

    /**
     * @var NTA
     *
     * @ORM\ManyToOne(targetEntity="App\Entity\NTA")
     * @ORM\JoinColumn(name="nta_id", referencedColumnName="id", nullable=true)
     */
    private $nta;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTitle(): ?string
    {
        return $this->title;
    }

    public function setTitle(string $title): self
    {
        $this->title = $title;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(string $description): self
    {
        $this->description = $description;

        return $this;
    }

    public function getPlace(): ?string
    {
        return $this->place;
    }

    public function setPlace(string $place): self
    {
        $this->place = $place;

        return $this;
    }

    public function __toString()
    {
        return $this->title;
    }

    /**
     * @return NTA
     */
    public function getNTA()
    {
        return $this->nta;
    }

    /**
     * @param NTA $nta
     * @return NActivity
     */
    public function setNTA(NTA $nta = null)
    {
        $this->nta = $nta;
        return $this;
    }

}
